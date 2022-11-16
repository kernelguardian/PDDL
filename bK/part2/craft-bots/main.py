import argparse
from agents.rule_based_agent import RBAgent
from craftbots.simulation import Simulation
from gui.main_window import CraftBotsGUI
from agents.assignment_Agent import Assignment_Agent

if __name__ == '__main__':

    # parse command line arguments
    arg_parser = argparse.ArgumentParser()
    # arg_parser.add_argument('-f', help="configuration file", type=str, default='craftbots/config/simple_configuration.yaml')
    # arg_parser.add_argument('-f', help="configuration file", type=str, default='craftbots/config/2022part1_configuration.yaml')
    arg_parser.add_argument('-f', help="configuration file", type=str, default='craftbots/config/part2_configurationV2.yaml')
    args = arg_parser.parse_args()

    # Simulation
    sim = Simulation(configuration_file=args.f)

    # agent
    # agent = RBAgent()
    # sim.agents.append(agent)

    agent = Assignment_Agent()
    sim.agents.append(agent)

    # GUI
    gui = CraftBotsGUI(sim)
    gui.start_window()



    

