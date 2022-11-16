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
        WAITING   = 3
        DONE      = 4

    api: agent_api.AgentAPI
    pddl_interface: PDDLInterface

    def __init__(self):

        super().__init__()

        self.state = Assignment_Agent.STATE.READY

        self.verbose = 1

        self.tasks_dict = None
        
        


    def get_next_commands(self):
        if self.state == Assignment_Agent.STATE.READY:
           
            tasks=[]
            for task in self.world_info['tasks'].values():
                print('task status', task['completed'])
                tasks.append(task['completed'])
            

            if (all (tasks)):
                self.state = Assignment_Agent.STATE.WAITING

            else:
                for task in self.world_info['tasks'].values():
                    if task['completed']:
                        print(task['id'])

                self.state = Assignment_Agent.STATE.PLANNING

                PDDLInterface.writeProblem(world_info=self.world_info)

                PDDLInterface.generatePlan("agents/domain-craft-bots.pddl", "agents/problem.pddl", "agents/plan.pddl", verbose=True)

                self.plan = PDDLInterface.readPDDLPlan('agents/plan.pddl')

                self.state = Assignment_Agent.STATE.EXECUTING
            
        elif self.state == Assignment_Agent.STATE.EXECUTING:
            if len(self.plan) == 0:
                self.state = Assignment_Agent.STATE.READY
                for actor in self.world_info['actors'].values():
                    if actor['state'] != 0:
                        self.state = Assignment_Agent.STATE.EXECUTING

            else:
                 action, params = self.plan[0]

                 if self.world_info['actors'][params[0]]['state'] == 0:
                    self.plan.pop(0)
                    self.send_action(action, params)
                    
                    self.state = Assignment_Agent.STATE.WAITING

        elif self.state == Assignment_Agent.STATE.WAITING:
            self.state = Assignment_Agent.STATE.EXECUTING

        self.thinking = False

    def send_action(self, action, params):
        print(self.api.actors)
        if action == 'move':
            print("Move Action Executing!!")
            self.api.move_to(params[0],params[2])

        if action == 'start_construction':
            print("Start Building")
            for actor_id, actors in self.world_info['actors'].items():
                if actor_id == params[0]:
                    current_node = self.api.get_field(actor_id, "node")
                    for task_id, task in self.world_info['tasks'].items():
                        target_node = self.api.get_field(task_id, "node")
                        if target_node == current_node == params[1]:
                            self.api.start_site(actor_id,task_id)
        if action == 'mine':
            print("Mining.............")
            for actor_id, actors in self.world_info['actors'].items():
                if actor_id == params[0]:
                    current_node = self.api.get_field(actor_id, "node")
                    for mine_id, mine in self.world_info['mines'].items():
                        mine_node = self.api.get_field(mine_id, "node")
                        if mine_node == current_node:
                            self.api.dig_at(actor_id,mine_id)
  
        if action == 'pick-up':
            print("PICK UP")
            for actor_id, actors in self.world_info['actors'].items():
                if actor_id == params[0]:
                    current_node = self.api.get_field(actor_id, "node")
                    for resource_id, res in self.world_info['resources'].items():
                        resource_node = self.api.get_field(resource_id,'location')
                        if current_node == resource_node == params[1]:
                            resource_colour = self.api.get_field(resource_id,'colour')
                            if resource_colour == params[2]:
                                self.api.pick_up_resource(actor_id,resource_id)
        if action == 'deposit':
            print("deposit")
            for actor_id, actors in self.world_info['actors'].items():
                if actor_id == params[0]:
                    current_node = self.api.get_field(actor_id, "node")
                    current_resources = self.api.get_field(actor_id,"resources")
                    for site_id, sites in self.world_info['sites'].items():
                        current_site = self.api.get_field(site_id, "node")
                        for res in sites['needed_resources']:
                            if res in current_resources:
                                for resource_id, rcol in self.world_info['resources'].items():
                                    resource = self.api.get_field('colour',resource_id)
                                    if resource == params[2]:
                                        self.api.deposit_resources(actor_id, site_id, resource_id) 
        if action == 'complete_construction':
            print("complete_construction")
            for actor_id, actors in self.world_info['actors'].items():
                if actor_id == params[0]:
                    current_node = self.api.get_field(actor_id, "node")
                    for site_id, sites in self.world_info['sites'].items():
                        current_site = self.api.get_field(site_id, "node")
                        if current_node == current_site:
                            self.api.construct_at(actor_id,site_id)
                            # self.api.drop_all_resources(actor_id)
                            a = self.api.get_world_info()
                            print(a)


 


            


