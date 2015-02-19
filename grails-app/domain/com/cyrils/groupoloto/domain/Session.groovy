package com.cyrils.groupoloto.domain

class Session {

    static hasMany = [players: Player]

    String id

    String name

    Date date = new Date()
    Boolean open = true
    Double gains = 0D;

    static constraints = {
        date nullable: false
        open nullable: false
        gains nullable: false
        name nullable: false
    }

    static mapping = {
        id generator: 'uuid'
    }

    Date dateCreated
    Date lastUpdated
}
