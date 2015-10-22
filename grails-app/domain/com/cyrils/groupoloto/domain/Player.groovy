package com.cyrils.groupoloto.domain

class Player {

    String id

    String lastname
    String firstname
    String email

    Double current = 0D

    Integer automationForNextGame = 0

    boolean deleted = false

    static constraints = {
        lastname nullable: false, blank: false
        firstname nullable: false, blank: false
        email nullable: false, blank: false, email: true, unique: true
        current nullable: false, defaultValue: 0D
        automationForNextGame nullable: true, defaultValue: 0
        deleted nullable:true
    }

    static mapping = {
        id generator: 'uuid'
    }

    Date dateCreated
    Date lastUpdated
}
