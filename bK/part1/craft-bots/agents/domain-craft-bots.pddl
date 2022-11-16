; ;Header and description

;Header and description

(define (domain craft-bots)

  ;remove requirements that are not needed
  (:requirements :strips :equality :typing :conditional-effects :fluents :duration-inequalities :timed-initial-literals)

  (:types
    actor resource node
  )

  (:predicates
    (actor_state ?actor - actor)
    (allocation ?actor - actor ?node - location)
    (connects ?nodea - location ?nodeb - location)
    (building_location ?node - location ?actor - actor)
    (mining ?actor - actor ?node - location ?resource - resource)
    (resource_color ?resource - resource ?actor - actor)
    (r_location ?resource - resource ?node - location ?actor - actor)
    (carry ?actor - actor ?resource - resource)
    (deposit_resource ?actor - actor ?resource - resource ?node - location)
    (building_position ?node - location)
    (building_start ?node - location ?actor - actor)
    (actor_free ?actor - actor)
    (construct_building ?node - location ?actor - actor)

  )

  (:functions

    (r_count ?node - location ?actor - actor)
    (total_resource_req ?node - location ?actor - actor)
    (mine_resource ?resource - resource ?node - location ?actor - actor)

  )

  ; Action to move actors between nodes 
  (:action move_actors
    :parameters (?actor - actor ?nodea - location ?nodeb - location)

    :precondition (and
      (actor_state ?actor)
      (allocation ?actor ?nodea)
      (connects ?nodea ?nodeb)
    )
    :effect (and
      (not (allocation ?actor ?nodea))
      (not (allocation ?actor ?nodeb))
      (allocation ?actor ?nodeb)

    )

  )

  ; action : create_building - Function : Actor will create the site for the building on the node.

  (:action create_building
    :parameters (?actor - actor ?node - location)
    :precondition (and
      (actor_state ?actor)
      (allocation ?actor ?node)
      (building_start ?node ?actor)
    )
    :effect (and
      (not (actor_free ?actor))
      (allocation ?actor ?node)
      (building_location ?node ?actor)
      (building_position ?node)
      (actor_free ?actor)
    )

  )

  ; action : mine - Function : Actor will mine the resources from the node.

  (:action mine
    :parameters (?actor - actor ?node - location ?resource - resource)
    :precondition(and
      (allocation ?actor ?node)
      (actor_state ?actor)
      (r_location ?resource ?node ?actor)
      (resource_color ?resource ?actor)
      (actor_free ?actor)

    )
    :effect (and
      (building_position ?node)
      (building_location ?node ?actor)
      (allocation ?actor ?node)
      (resource_color ?resource ?actor)
      (r_location ?resource ?node ?actor)
      (mining ?actor ?node ?resource)

    )
  )

  ; action : pick_up - Function : Actor will pick up the mined resource  from the node.

  (:action pick_up
    :parameters (?actor - actor ?node - location ?resource - resource)
    :precondition(and

      (allocation ?actor ?node)
      (actor_state ?actor)
      (r_location ?resource ?node ?actor)
      (resource_color ?resource ?actor)
      (mining ?actor ?node ?resource)
      (>(mine_resource ?resource ?node ?actor)0)
      (actor_free ?actor)

    )
    :effect(and
      (not(deposit_resource ?actor ?resource ?node))
      (carry ?actor ?resource)
      (not(actor_free ?actor))
      (decrease
        (mine_resource ?resource ?node ?actor)
        1)
    )
  )

  ; action : deposit - Function : Actor will deposit the carrying resource on the site node.

  (:action deposit
    :parameters (?actor - actor ?node - location ?resource - resource)
    :precondition (and
      (resource_color ?resource ?actor)
      (carry ?actor ?resource)
      (allocation ?actor ?node)
      (actor_state ?actor)
    )
    :effect (and
      (not (actor_free ?actor))
      (actor_free ?actor)
      (deposit_resource ?actor ?resource ?node)
      (not (carry ?actor ?resource))
      (increase (r_count ?node ?actor) 1)
    )

  )

  ; action : complete_building - Function : Once resources conditions are stisfied, actor will cnstruct -
  ;building on the site node.

  (:action complete_building
    :parameters (?actor - actor ?node - location)
    :precondition (and
      (actor_state ?actor)
      (actor_state ?actor)
      (>=(r_count ?node ?actor)(total_resource_req ?node ?actor))

    )
    :effect (and
      (construct_building ?node ?actor)
      (not (actor_state ?actor))
    )
  )

)