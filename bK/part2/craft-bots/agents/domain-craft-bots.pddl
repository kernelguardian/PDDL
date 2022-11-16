;Header and description

(define (domain craft-bots)

;remove requirements that are not needed
(:requirements 
:strips :equality :typing :conditional-effects :fluents :durative-actions :duration-inequalities :timed-initial-literals)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle

actor resource node

)

; un-comment following line if constants are needed
;(:constants )

(:predicates ;todo: define predicates here

(actorstate ?actor - actor)
(alocation ?actor - actor  ?node - location)
(connects ?nodea - location ?nodeb - location)


(buildinglocation ?node - location ?actor - actor)
(mining ?actor - actor ?node - location ?resource - resource)

(resource_color ?resource - resource ?actor - actor)
(r_location ?resource - resource ?node - location ?actor - actor)

(carry ?actor - actor ?resource - resource)

(deposit_resource ?actor - actor  ?resource - resource ?node - location)

(building_at ?node - location)
(building_start ?node - location ?actor - actor)

(actor_free ?actor - actor)

(construct_building ?node - location ?actor - actor)


)


(:functions ;todo: define numeric functions here


(r_resource_count ?node - location ?actor - actor)

;(r_resource_count ?node - location ?actor - actor ?resource - resource)
(total_resource_req ?node - location ?actor - actor)

;(total_resource_req_red ?node - location ?actor - actor ?resource - resource)
;(total_resource_req_blue ?node - location ?actor - actor ?resource - resource)

(mine_resource ?resource - resource ?node - location ?actor - actor)

(mine_duration ?resource - resource)

)

;define actions here

(:durative-action move

    :parameters (?actor - actor ?nodea - location ?nodeb - location)
    :duration (= ?duration 1)
    :condition (and 
        (over all(actorstate ?actor ))
        (at start (alocation ?actor  ?nodea))
        (over all (connects ?nodea ?nodeb))
    )
    :effect (and 
        (at start (not (alocation ?actor  ?nodea)) )
        (at start (not (alocation ?actor  ?nodeb)) )
        (at end (alocation ?actor  ?nodeb))


        
    )

)

(:durative-action start-building
  :parameters (?actor - actor ?node - location )
  :duration (= ?duration 2)
  :condition (and 
  (over all (actorstate ?actor))
  (at start  (alocation ?actor ?node))
   (at start (building_start ?node ?actor)) 
  )
  :effect (and 
  (at start (not (actor_free ?actor)))
    (at end (alocation ?actor  ?node))
    (at end (buildinglocation ?node ?actor))
    (at end (building_at ?node))
    (at end (actor_free ?actor))
  )

)


(:durative-action mine
    :parameters (?actor - actor ?node - location  ?resource - resource)
    :duration (= ?duration (mine_duration ?resource))
    :condition(and 
       (at start (alocation ?actor ?node))
       (over all (actorstate ?actor))
       (at start(r_location ?resource ?node ?actor))
       (over all(resource_color ?resource ?actor))
       (at start (actor_free ?actor))
       
    )
    :effect (and 
       (at start (building_at ?node))
       (at start (buildinglocation ?node ?actor))
       (at end (alocation ?actor  ?node))
       (at end(resource_color ?resource ?actor))
       (at end(r_location ?resource ?node ?actor))
       (at end (mining ?actor ?node ?resource))


    )
)

(:durative-action pick-up
    :parameters (?actor - actor ?node - location  ?resource - resource)
    :duration (= ?duration (mine_duration ?resource))
    :condition(and
     
      (over all (alocation ?actor ?node))
      (over all (actorstate ?actor))
      (at start (r_location ?resource ?node ?actor))
      (over all(resource_color ?resource ?actor))
      (at start(mining ?actor ?node ?resource))
      (over all (>(mine_resource ?resource ?node ?actor)0))
      (at start (actor_free ?actor))
      
    )
    :effect(and
    ;(at start (not(carry ?actor ?resource)))
    (at start (not(deposit_resource ?actor ?resource ?node)))
    (at end (carry ?actor ?resource))
    (at end (not(actor_free ?actor)))
    (at end (decrease (mine_resource ?resource ?node ?actor) 1))
    )
)


(:durative-action deposite
    :parameters (?actor - actor ?node - location ?resource - resource)
    :duration (= ?duration (mine_duration ?resource))
    :condition (and 
    (over all(resource_color ?resource ?actor))
     (over all(carry ?actor ?resource))
     (over all (alocation ?actor ?node))
     (over all (actorstate ?actor))
    )
    :effect (and  
    (at start (not (actor_free ?actor)))
    (at end (actor_free ?actor))
    (at end (deposit_resource ?actor ?resource ?node))
    (at end (not (carry ?actor ?resource)))
    (at end (increase (r_resource_count ?node ?actor ) 1))
    )


)

(:durative-action complete-building
  :parameters (?actor - actor ?node - location  )
  :duration (= ?duration 1)
  :condition (and 
  (over all (actorstate ?actor))
    ;(at start  (actorstate ?actor))
    (at start (>=(r_resource_count ?node ?actor )(total_resource_req ?node ?actor)))
    ;(at start (>=(r_resource_count ?node ?actor ?resource)(total_resource_req_red ?node ?actor ?resource)))
  )
  :effect (and 
    (at end (construct_building ?node ?actor))
    (at end (not (actorstate ?actor)))
  )
)

)