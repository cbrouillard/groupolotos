package com.cyrils.groupoloto.domain

class Session {

    static hasMany = [players: Player]

    String id

    String name

    Date date = new Date()
    Boolean open = true
    byte[] proofTicket
    Double gains = 0D;

    static constraints = {
        date nullable: false
        open nullable: false
        // Limit upload file size to 5MB
        proofTicket maxSize: 1024 * 1024 * 5, nullable:true
        gains nullable: false
        name nullable: false
    }

    static mapping = {
        id generator: 'uuid'
    }

    Date dateCreated
    Date lastUpdated
}
