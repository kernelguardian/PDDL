import random
import time

from agents.PDDLInterface import PDDLInterface
from api import agent_api
from craftbots.entities.building import Building
from agents.agent import Agent

class Assignment_Agent(Agent):

    class STATE:
        READY     = 0
        PLANNING  = 1
        EXECUTING = 2
        # this state skips the frame after
        # an action is dispatched to avoid
        # misreading the actor state.
        WAITING   = 3
        DONE      = 4

    api: agent_api.AgentAPI
    pddl_interface: PDDLInterface

    def __init__(self):

        super().__init__()

        # Set an initial state of being ready.
        self.state = Assignment_Agent.STATE.READY

        # Set the agent to be verbose (printing out commands)
        self.verbose = 1


    # Function to choose the next commands
    # Main function for writing plans etc.
    # does not execute anything, is purely for testing plan
    def get_next_commands(self):
        # You can use this to test your PDDL
        PDDLInterface.writeProblem(world_info=self.world_info)

        # Now try to generate a plan
        PDDLInterface.generatePlan("agents/domain-craft-bots.pddl", "agents/problem.pddl", "agents/plan.pddl", verbose=True)
        

    # A more complete version, which only creates a plan etc if needed
    # Rename to get_next_commands(self) to use
    def get_next_commands_v1(self):
        #  Completed, do not need to edit

        # If they are ready for instructions
        if self.state == Assignment_Agent.STATE.READY:
           
            # Get a list of tasks and add them to a list
            # check if they are all completed
            tasks=[]
            for task in self.world_info['tasks'].values():
                print('task status', task['completed'])
                tasks.append(task['completed'])
            
            # If all tasks completed, set state to waiting
            if (all (tasks)):
                self.state = Assignment_Agent.STATE.WAITING

            # if all tasks not completed, need to process
            else:
                # Print a list of all completed tasks
                for task in self.world_info['tasks'].values():
                    if task['completed']:
                        print(task['id'])

                # Put agent in planning state
                self.state = Assignment_Agent.STATE.PLANNING

                # Generate Problem and plan and prepare to execute
                PDDLInterface.writeProblem(world_info=self.world_info)

                # Now generate a plan
                PDDLInterface.generatePlan("agents/domain-craft-bots.pddl", "agents/problem.pddl", "agents/plan.pddl", verbose=True)

                # Read the plan (completed)
                self.plan = PDDLInterface.readPDDLPlan('agents/plan.pddl')

                # Set agent to be executing a plan
                self.state = Assignment_Agent.STATE.EXECUTING
            
        # If its executing, need to fill in again
        elif self.state == Assignment_Agent.STATE.EXECUTING:
            # print('executing')
            # If the plan is zero, i.e. no plan
            if len(self.plan) == 0:
                # set agent to be ready
                self.state = Assignment_Agent.STATE.READY
                # Check all the actors, if any are busy, change state to executing
                for actor in self.world_info['actors'].values():
                    if actor['state'] != 0:
                        self.state = Assignment_Agent.STATE.EXECUTING

            # Otherwise, if a plan exists, 
            else:
                # Set our first action
                 action, params = self.plan[0]
                 # check if any actors are ready
                 if self.world_info['actors'][params[0]]['state'] == 0:
                    # Pop first action off stack
                    self.plan.pop(0)
                    #  Send action for agent to execute
                    # call send function
                    self.send_action(action, params)
                    
                    self.state = Assignment_Agent.STATE.WAITING

        # if its waiting, set it to executing.  completed
        elif self.state == Assignment_Agent.STATE.WAITING:
           # print('waiting, so make it execute')
            self.state = Assignment_Agent.STATE.EXECUTING

        # finished thinking
        self.thinking = False

    # Function that actually carries out the action
    # receives actions and params, 
    def send_action(self, action, params):
        # To be completed
        print('no actions work yet!')