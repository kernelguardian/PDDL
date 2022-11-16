from collections.abc import Set
from typing import List, Tuple, Union
import requests

class PDDLInterface:

    COLOURS = ['red', 'blue', 'orange', 'black', 'green']
    ACTIONS = ['move', 'mine', 'pick_up', 'drop', 'start-building', 'deposit', 'complete_building']

    @staticmethod
    # Function to write a problem file
    # Complete this function

    def writeProblem(world_info, file="agents/problem.pddl"):
        # Function that will

        with open(file, "w") as f:
            f.write("(define(problem craft-bots-problem)\n")
            f.write("(:domain craft-bots)\n")
            f.write("(:objects\n ")
            for actor in world_info['actors']:
                f.write("a"+ str(actor) +" ")
            f.write("- actor\n ")

            for node in world_info['nodes']:
                f.write("n"+str(node)+" ")
            f.write("- location\n ")

            for resource in PDDLInterface.COLOURS:
                f.write(str(resource)+" ")
            f.write("- resource\n ")    
            f.write(") \n")

            f.write("(:init\n")
            for actor in world_info['actors']:
                f.write("(actor_state a"+str(actor)+")\n") 

            for actor in world_info['actors']:
                f.write("(allocation a"+str(actor)+" n"+str(world_info['actors'][actor]['node'])+")\n")
            actor_list = []

            for d1 in world_info['actors']:
                actor_list.append(world_info['actors'][d1]['id'])
            # f.write(str(actor_dict))
            building_list = []
            for d1 in world_info['tasks']:
                building_list.append(world_info['tasks'][d1]['node']) 
            print(building_list) 
            print(world_info['tasks'])
            for actor,bid in zip(actor_list,building_list):
                f.write("(building_start n"+str(bid)+" a"+str(actor)+")\n")    

            write_list1 = []

            for key,value in world_info['tasks'].items():
                str1 = "(building_start n"+str(value['node'])+" a"
                write_list1.append(str1)

            write_list2 = []
            for key,val in world_info['actors'].items():
                str1 = str(key)+")\n"
                write_list2.append(str1)    

            print(write_list1)   
            print(write_list2)  
            print("ZIP")

            for a in zip(write_list1,write_list2):
                print(a)
                
            for color in PDDLInterface.COLOURS:
                for actor in actor_list:
                    f.write("(resource_color "+str(color)+" a"+str(actor)+")\n")
            mine_list = []
            combo_list = []
            for m in  world_info['mines']:
                for actor in actor_list:
                    f.write("(r_location ")
                    colour = ''
                    if world_info['mines'][m]['colour'] == 0:
                        colour = 'red'
                    if world_info['mines'][m]['colour'] == 1:
                        colour = 'blue'
                    if world_info['mines'][m]['colour'] == 2:
                        colour = 'orange'
                    if world_info['mines'][m]['colour'] == 3:
                        colour = 'black'
                    if world_info['mines'][m]['colour'] == 4:
                        colour = 'green' 
                    f.write(str(colour)+" n"+str(world_info['mines'][m]['node'])+" a"+str(actor)+")\n")
                    combo_list.append("(mine_resource "+str(colour)+" n"+str(world_info['mines'][m]['node'])+" a"+str(actor)+")")  
            
            resource_list = []
            for key, val in world_info['tasks'].items():
                resource_list.append(world_info['tasks'][key]['needed_resources'])
            print(">>>>>>ACTOR LIST<<<<<<<<")
            print(actor_list)    
            print(">>>>>>Resource LIST<<<<<<<<")
            print(resource_list)   
            # f.write(str(resource_list)+"\n")    
            for m in world_info['mines']:
                # f.write(str(world_info['mines'][m]))
                # f.write("\n")
                color_indx = world_info['mines'][m]['colour']
                # f.write(str(color_indx))
                if color_indx == 0:
                    colour = 'red'
                if color_indx == 1:
                    colour = 'blue'
                if color_indx == 2:
                    colour = 'orange'
                if color_indx == 3:
                    colour = 'black'
                if color_indx == 4:
                    colour = 'green'
                node =  world_info['mines'][m]['node']  

                len_actor = len(actor_list)
                i = 0

                
                               
                for a, r in zip(actor_list,resource_list):
                    f.write("(=(mine_resource "+str(colour)+" n"+str(node)+" a"+str(a)+")"+str(r[color_indx])+")\n")



            building_list = []
            for d1 in world_info['tasks']:
                building_list.append(world_info['tasks'][d1]['node']) 
            for actor,bid in zip(actor_list,building_list):
                f.write("(=(r_count n"+str(bid)+" a"+str(actor)+")0"+")\n")
                
            building_list = []
            resource_list = []  
            for d1 in world_info['tasks']:
                building_list.append(world_info['tasks'][d1]['node'])
            for key, val in world_info['tasks'].items():
                resource_list.append(world_info['tasks'][key]['needed_resources'])  

            for actor, node, resource in zip(actor_list,building_list,resource_list):
                f.write("(=(total_resource_req n"+str(node)+" a"+str(actor)+") "+str(sum(resource))+")\n")      
                                  
                
                  
            for connects in world_info['edges']:
                f.write("(connects n"+str(world_info['edges'][connects]['node_a'])+" n"+str(world_info['edges'][connects]['node_b'])+")\n")

            for connects in world_info['edges']:
                f.write("(connects n"+str(world_info['edges'][connects]['node_b'])+" n"+str(world_info['edges'][connects]['node_a'])+")\n")        
                    

            f.write(")\n")

            f.write("(:goal (and \n")

            building_list = []
            for d1 in world_info['tasks']:
                building_list.append(world_info['tasks'][d1]['node']) 
            # f.write(str(building_dict))  
            # for actor,bid in zip(actor_list,building_list):
            #     f.write("(building_location n"+str(bid)+" a"+str(actor)+")\n")

            for bid,a in zip(building_list,actor_list):
                f.write("(construct_building n"+str(bid)+" a"+str(a)+")\n")

            f.write("))")    


            f.write(") \n")
            f.close()

    @staticmethod
    def readPDDLPlan(file: str):
        # Completed already, will read a generated plan from file
        plan = []
        with open(file, "r") as f:
            line = f.readline().strip()
            while line:
                tokens = line.split()
                action = tokens[1][1:]
                params = tokens [2:-1]
                # remove trailing bracket
                params[-1] = params[-1][:-1]
                # remove character prefix and convert colours to ID
                params = [int(p[1:]) if p not in PDDLInterface.COLOURS else PDDLInterface.COLOURS.index(p) for p in params]
                plan.append((action, params))
                line = f.readline().strip()
            f.close()
        return plan

    @staticmethod
    # Completed already
    def generatePlan(domain: str, problem: str, plan: str, verbose=False):
        data = {'domain': open(domain, 'r').read(), 'problem': open(problem, 'r').read()}
        resp = requests.post('https://popf-cloud-solver.herokuapp.com/solve', verify=True, json=data).json()
        if not 'plan' in resp['result']:
            if verbose:
                print("WARN: Plan was not found!")
                print(resp)
            return False
        with open(plan, 'w') as f:
            f.write(''.join([act for act in resp['result']['plan']]))
        f.close()
        return True

if __name__ == '__main__':
    PDDLInterface.generatePlan("domain-craft-bots.pddl", "problem.pddl", "plan.pddl", verbose=True)
    plan = PDDLInterface.readPDDLPlan('plan.pddl')
    print(plan)