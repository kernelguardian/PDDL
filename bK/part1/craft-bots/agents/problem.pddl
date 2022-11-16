(define(problem craft-bots-problem)
(:domain craft-bots)
(:objects
 a29 a28 a30 - actor
 n0 n1 n3 n5 n7 n10 n12 n14 n16 n18 - location
 red blue orange black green - resource
 ) 
(:init
(actorstate a29)
(actorstate a28)
(actorstate a30)
(alocation a29 n3)
(alocation a28 n18)
(alocation a30 n18)
(building_start n16 a29)
(building_start n18 a28)
(building_start n16 a30)
(resource_color red a29)
(resource_color red a28)
(resource_color red a30)
(resource_color blue a29)
(resource_color blue a28)
(resource_color blue a30)
(resource_color orange a29)
(resource_color orange a28)
(resource_color orange a30)
(resource_color black a29)
(resource_color black a28)
(resource_color black a30)
(resource_color green a29)
(resource_color green a28)
(resource_color green a30)
(r_location blue n1 a29)
(r_location blue n1 a28)
(r_location blue n1 a30)
(r_location black n3 a29)
(r_location black n3 a28)
(r_location black n3 a30)
(r_location green n7 a29)
(r_location green n7 a28)
(r_location green n7 a30)
(r_location orange n16 a29)
(r_location orange n16 a28)
(r_location orange n16 a30)
(r_location red n18 a29)
(r_location red n18 a28)
(r_location red n18 a30)
(=(mine_resource blue n1 a29)1)
(=(mine_resource blue n1 a28)0)
(=(mine_resource blue n1 a30)2)
(=(mine_resource black n3 a29)1)
(=(mine_resource black n3 a28)1)
(=(mine_resource black n3 a30)0)
(=(mine_resource green n7 a29)0)
(=(mine_resource green n7 a28)0)
(=(mine_resource green n7 a30)1)
(=(mine_resource orange n16 a29)0)
(=(mine_resource orange n16 a28)1)
(=(mine_resource orange n16 a30)0)
(=(mine_resource red n18 a29)0)
(=(mine_resource red n18 a28)0)
(=(mine_resource red n18 a30)1)
(=(r_resource_count n16 a29)0)
(=(r_resource_count n18 a28)0)
(=(r_resource_count n16 a30)0)
(=(total_resource_req n16 a29) 2)
(=(total_resource_req n18 a28) 2)
(=(total_resource_req n16 a30) 4)
(connects n1 n0)
(connects n3 n1)
(connects n5 n3)
(connects n7 n3)
(connects n7 n5)
(connects n10 n7)
(connects n12 n10)
(connects n18 n10)
(connects n14 n12)
(connects n18 n12)
(connects n16 n14)
(connects n18 n16)
(connects n0 n1)
(connects n1 n3)
(connects n3 n5)
(connects n3 n7)
(connects n5 n7)
(connects n7 n10)
(connects n10 n12)
(connects n10 n18)
(connects n12 n14)
(connects n12 n18)
(connects n14 n16)
(connects n16 n18)
)
(:goal (and 
(construct_building n16 a29)
(construct_building n18 a28)
(construct_building n16 a30)
))) 
