(define(problem craft-bots-problem)
(:domain craft-bots)
(:objects
 a33 a34 a32 - actor
 n0 n1 n3 n5 n8 n11 n13 n15 n19 n23 - location
 red blue orange black green - resource
 ) 
(:init
(actorstate a33)
(actorstate a34)
(actorstate a32)
(alocation a33 n1)
(alocation a34 n3)
(alocation a32 n11)
(building_start n23 a33)
(building_start n0 a34)
(building_start n0 a32)
(resource_color red a33)
(resource_color red a34)
(resource_color red a32)
(resource_color blue a33)
(resource_color blue a34)
(resource_color blue a32)
(resource_color orange a33)
(resource_color orange a34)
(resource_color orange a32)
(resource_color black a33)
(resource_color black a34)
(resource_color black a32)
(resource_color green a33)
(resource_color green a34)
(resource_color green a32)
(r_location green n0 a33)
(r_location green n0 a34)
(r_location green n0 a32)
(r_location red n11 a33)
(r_location red n11 a34)
(r_location red n11 a32)
(r_location blue n11 a33)
(r_location blue n11 a34)
(r_location blue n11 a32)
(r_location orange n19 a33)
(r_location orange n19 a34)
(r_location orange n19 a32)
(r_location black n19 a33)
(r_location black n19 a34)
(r_location black n19 a32)
(=(mine_resource green n0 a33)1)
(=(mine_resource green n0 a34)1)
(=(mine_resource green n0 a32)1)
(=(mine_resource red n11 a33)0)
(=(mine_resource red n11 a34)1)
(=(mine_resource red n11 a32)0)
(=(mine_resource blue n11 a33)0)
(=(mine_resource blue n11 a34)0)
(=(mine_resource blue n11 a32)1)
(=(mine_resource orange n19 a33)1)
(=(mine_resource orange n19 a34)2)
(=(mine_resource orange n19 a32)3)
(=(mine_resource black n19 a33)0)
(=(mine_resource black n19 a34)0)
(=(mine_resource black n19 a32)0)
(=(r_resource_count n23 a33)0)
(=(r_resource_count n0 a34)0)
(=(r_resource_count n0 a32)0)
(=(total_resource_req n23 a33) 2)
(=(total_resource_req n0 a34) 4)
(=(total_resource_req n0 a32) 5)
(connects n1 n0)
(connects n3 n1)
(connects n5 n1)
(connects n5 n3)
(connects n8 n3)
(connects n19 n3)
(connects n23 n3)
(connects n8 n5)
(connects n11 n8)
(connects n15 n8)
(connects n19 n8)
(connects n13 n11)
(connects n15 n11)
(connects n15 n13)
(connects n19 n15)
(connects n23 n19)
(connects n0 n1)
(connects n1 n3)
(connects n1 n5)
(connects n3 n5)
(connects n3 n8)
(connects n3 n19)
(connects n3 n23)
(connects n5 n8)
(connects n8 n11)
(connects n8 n15)
(connects n8 n19)
(connects n11 n13)
(connects n11 n15)
(connects n13 n15)
(connects n15 n19)
(connects n19 n23)
)
(:goal (and 
(construct_building n23 a33)
(construct_building n0 a34)
(construct_building n0 a32)
))) 