package com.cyrils.groupoloto.domain

class Groupo {

    static hasManySessions = [sessions: Session]

    static hasManyPlayers = [players: Player]

    String id

    String name

    Boolean enable = true

    static constraints = {
        name nullable: false
        enable nullable: false
    }

    static mapping = {
        id generator: 'uuid'
    }

    Date dateCreated
    Date lastUpdated

}
