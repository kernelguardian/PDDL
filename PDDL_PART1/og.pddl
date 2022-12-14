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

        (actorstate ?actor - actor)
        (alocation ?actor - actor ?node - location)
        (connects ?nodea - location ?nodeb - location)

        (buildinglocation ?node - location ?actor - actor)
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
            (actorstate ?actor)
            (alocation ?actor ?nodea)
            (connects ?nodea ?nodeb)
        )
        :effect (and
            (not (alocation ?actor ?nodea))
            (not (alocation ?actor ?nodeb))
            (alocation ?actor ?nodeb)

        )

    )

    (:action start-building
        :parameters (?actor - actor ?node - location)
        :precondition (and
            (actorstate ?actor)
            (alocation ?actor ?node)
            (building_start ?node ?actor)
        )
        :effect (and
            (not (actor_free ?actor))
            (alocation ?actor ?node)
            (buildinglocation ?node ?actor)
            (building_at ?node)
            (actor_free ?actor)
        )

    )

    (:action mine
        :parameters (?actor - actor ?node - location ?resource - resource)
        :precondition(and
            (alocation ?actor ?node)
            (actorstate ?actor)
            (r_location ?resource ?node ?actor)
            (resource_color ?resource ?actor)
            (actor_free ?actor)

        )
        :effect (and
            (building_at ?node)
            (buildinglocation ?node ?actor)
            (alocation ?actor ?node)
            (resource_color ?resource ?actor)
            (r_location ?resource ?node ?actor)
            (mining ?actor ?node ?resource)

        )
    )

    (:action pick-up
        :parameters (?actor - actor ?node - location ?resource - resource)
        :precondition(and

            (alocation ?actor ?node)
            (actorstate ?actor)
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
            (alocation ?actor ?node)
            (actorstate ?actor)
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
            (actorstate ?actor)
            (actorstate ?actor)
            (>=(r_resource_count ?node ?actor)(total_resource_req ?node ?actor))
            ;(at start (>=(r_resource_count ?node ?actor ?resource)(total_resource_req_red ?node ?actor ?resource)))
        )
        :effect (and
            (construct_building ?node ?actor)
            (not (actorstate ?actor))
        )
    )

)