(define(problem craft-bots-problem)
(:domain craft-bots)
(:objects
 a25 a24 a26 - actor
 n0 n1 n3 n5 n9 n12 n14 n16 n18 n21 - location
 red blue orange black green - resource
 ) 
(:init
(actorstate a25)
(actorstate a24)
(actorstate a26)
(alocation a25 n12)
(alocation a24 n16)
(alocation a26 n21)
(building_start n12 a25)
(resource_color red a25)
(resource_color red a24)
(resource_color red a26)
(resource_color blue a25)
(resource_color blue a24)
(resource_color blue a26)
(resource_color orange a25)
(resource_color orange a24)
(resource_color orange a26)
(resource_color black a25)
(resource_color black a24)
(resource_color black a26)
(resource_color green a25)
(resource_color green a24)
(resource_color green a26)
(r_location black n1 a25)
(r_location black n1 a24)
(r_location black n1 a26)
(r_location green n1 a25)
(r_location green n1 a24)
(r_location green n1 a26)
(at 1(r_location red n3 a25))
(at 40(not(r_location red n3 a25)))
(at 1(r_location red n3 a24))
(at 40(not(r_location red n3 a24)))
(at 1(r_location red n3 a26))
(at 40(not(r_location red n3 a26)))
(r_location blue n16 a25)
(r_location blue n16 a24)
(r_location blue n16 a26)
(r_location orange n16 a25)
(r_location orange n16 a24)
(r_location orange n16 a26)
(=(mine_duration black)1)
(=(mine_duration green)1)
(=(mine_duration red)1)
(=(mine_duration blue)3)
(=(mine_duration orange)1)
(=(mine_resource black n1 a25)1)
(=(mine_resource green n1 a25)0)
(=(mine_resource red n3 a25)0)
(=(mine_resource blue n16 a25)2)
(=(mine_resource orange n16 a25)0)
(=(r_resource_count n12 a25)0)
(=(total_resource_req n12 a25) 3)
(connects n1 n0)
(connects n5 n0)
(connects n9 n0)
(connects n3 n1)
(connects n5 n1)
(connects n5 n3)
(connects n9 n5)
(connects n12 n9)
(connects n14 n12)
(connects n16 n14)
(connects n18 n14)
(connects n18 n16)
(connects n21 n18)
(connects n0 n1)
(connects n0 n5)
(connects n0 n9)
(connects n1 n3)
(connects n1 n5)
(connects n3 n5)
(connects n5 n9)
(connects n9 n12)
(connects n12 n14)
(connects n14 n16)
(connects n14 n18)
(connects n16 n18)
(connects n18 n21)
)
(:goal (and 
(construct_building n12 a25)
))) 
