(define(problem craft-bots-problem)
(:domain craft-bots)
(:objects
 a27 - actor
 n0 n1 n3 n5 n7 n9 n11 n13 n15 n17 - location
 red blue orange black green - resource
 ) 
(:init
(actor_state a27)
(alocation a27 n15)
(building_start n15 a27)
(resource_color red a27)
(resource_color blue a27)
(resource_color orange a27)
(resource_color black a27)
(resource_color green a27)
(r_location red n1 a27)
(r_location black n9 a27)
(r_location blue n13 a27)
(r_location green n15 a27)
(r_location orange n17 a27)
(=(mine_resource red n1 a27)0)
(=(mine_resource black n9 a27)1)
(=(mine_resource blue n13 a27)0)
(=(mine_resource green n15 a27)2)
(=(mine_resource orange n17 a27)2)
(=(r_resource_count n15 a27)0)
(=(total_resource_req n15 a27) 5)
(connects n1 n0)
(connects n3 n1)
(connects n5 n3)
(connects n7 n5)
(connects n17 n5)
(connects n9 n7)
(connects n17 n7)
(connects n11 n9)
(connects n13 n11)
(connects n15 n13)
(connects n17 n15)
(connects n0 n1)
(connects n1 n3)
(connects n3 n5)
(connects n5 n7)
(connects n5 n17)
(connects n7 n9)
(connects n7 n17)
(connects n9 n11)
(connects n11 n13)
(connects n13 n15)
(connects n15 n17)
)
(:goal (and 
(construct_building n15 a27)
))) 
