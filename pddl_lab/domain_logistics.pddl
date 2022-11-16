(define (domain basic_logistics)
    (:requirements :strips :typing)

    (:types
        location locatable - object
        package truck driver - locatable
    )

    (:predicates
        (connected ?from ?to - location)

        (at ?o - locatable ?l - location)
        (in ?p - package ?t - truck)
        (driving ?d - driver ?t - truck)
    )

    ;;================;;
    ;; driver actions ;;
    ;;================;;

    (:action walk
        :parameters (?d - driver ?from ?to - location)
        :precondition (and
            (at ?d ?from)
            (connected ?from ?to)
        )
        :effect (and
            (not (at ?d ?from))
            (at ?d ?to)
        )
    )

    (:action board_vehicle
        :parameters (?t - truck ?d - driver ?wp - location)
        :precondition (and
            (at ?d ?wp)
            (at ?t ?wp)
        )
        :effect (and
            (not (at ?d ?wp))
            (driving ?d ?t)
        )
    )

    (:action disembark_vehicle
        :parameters (?t - truck ?d - driver ?wp - location)
        :precondition (and
            (driving ?d ?t)
            (at ?t ?wp)
        )
        :effect (and
            (not (driving ?d ?t))
            (at ?d ?wp)
        )
    )

    ;;=================;;
    ;; vehicle actions ;;
    ;;=================;;

    (:action drive_truck
        :parameters (?t - truck ?d - driver ?from ?to - location)
        :precondition (and
            (at ?t ?from)
            (connected ?from ?to)
            (driving ?d ?t)
        )
        :effect (and
            (not (at ?t ?from))
            (at ?t ?to)
        )
    )

    ;;=================;;
    ;; package actions ;;
    ;;=================;;

    (:action load_package
        :parameters (?t - truck ?p - package ?wp - location)
        :precondition (and
            (at ?p ?wp)
            (at ?t ?wp)
        )
        :effect (and
            (not (at ?p ?wp))
            (in ?p ?t)
        )
    )

    (:action unload_package
        :parameters (?t - truck ?p - package ?wp - location)
        :precondition (and
            (in ?p ?t)
            (at ?t ?wp)
        )
        :effect (and
            (not (in ?p ?t))
            (at ?p ?wp)
        )
    )

)