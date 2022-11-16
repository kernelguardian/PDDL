;Header and description

(define (domain craft-bots)

  ;remove requirements that are not needed
  (:requirements :strips :equality :typing :conditional-effects :fluents :duration-inequalities :timed-initial-literals)

  (:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle

    actor resource node

  )

  ; un-comment following line if constants are needed
  ;(:constants )

  (:predicates ;todo: define predicates here

    (actor_state ?actor - actor)
    (allocate ?actor - actor ?node - location)
    (connect ?node_a - location ?node_b - location)

    (building_loc ?node - location ?actor - actor)
    (mining ?actor - actor ?node - location ?resource - resource)

    (resource_color ?resource - resource ?actor - actor)
    (r_location ?resource - resource ?node - location ?actor - actor)

    (carry ?actor - actor ?resource - resource)

    (deposit_resource ?actor - actor ?resource - resource ?node - location)

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

  )

  ;define actions here

  (:action move
    :parameters (?actor - actor ?nodea - location ?nodeb - location)

    :precondition (and
      (actor_state ?actor)
      (allocate ?actor ?nodea)
      (connect ?nodea ?nodeb)
    )
    :effect (and
      (not (allocate ?actor ?nodea))
      (not (allocate ?actor ?nodeb))
      (allocate ?actor ?nodeb)

    )

  )

  (:action start-building
    :parameters (?actor - actor ?node - location)
    :precondition (and
      (actor_state ?actor)
      (allocate ?actor ?node)
      (building_start ?node ?actor)
    )
    :effect (and
      (not (actor_free ?actor))
      (allocate ?actor ?node)
      (building_loc ?node ?actor)
      (building_at ?node)
      (actor_free ?actor)
    )

  )

  (:action mine
    :parameters (?actor - actor ?node - location ?resource - resource)
    :precondition(and
      (allocate ?actor ?node)
      (actor_state ?actor)
      (r_location ?resource ?node ?actor)
      (resource_color ?resource ?actor)
      (actor_free ?actor)

    )
    :effect (and
      (building_at ?node)
      (building_loc ?node ?actor)
      (allocate ?actor ?node)
      (resource_color ?resource ?actor)
      (r_location ?resource ?node ?actor)
      (mining ?actor ?node ?resource)

    )
  )

  (:action pick-up
    :parameters (?actor - actor ?node - location ?resource - resource)
    :precondition(and

      (allocate ?actor ?node)
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

  (:action deposite
    :parameters (?actor - actor ?node - location ?resource - resource)
    :precondition (and
      (resource_color ?resource ?actor)
      (carry ?actor ?resource)
      (allocate ?actor ?node)
      (actor_state ?actor)
    )
    :effect (and
      (not (actor_free ?actor))
      (actor_free ?actor)
      (deposit_resource ?actor ?resource ?node)
      (not (carry ?actor ?resource))
      (increase (r_resource_count ?node ?actor) 1)
    )

  )

  (:action complete-building
    :parameters (?actor - actor ?node - location)
    :precondition (and
      (actor_state ?actor)
      (actor_state ?actor)
      (>=(r_resource_count ?node ?actor)(total_resource_req ?node ?actor))
      ;(at start (>=(r_resource_count ?node ?actor ?resource)(total_resource_req_red ?node ?actor ?resource)))
    )
    :effect (and
      (construct_building ?node ?actor)
      (not (actor_state ?actor))
    )
  )

)