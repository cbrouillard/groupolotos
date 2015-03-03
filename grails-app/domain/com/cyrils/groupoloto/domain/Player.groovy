package com.cyrils.groupoloto.domain

class Player {

    static belongsTo = [groupo: Groupo]

    String id

    String lastname
    String firstname
    String email

    Double current = 0D

    static constraints = {
        lastname nullable:false, blank:false
        firstname nullable:false, blank:false
        email nullable:false, blank:false, email: true, unique: true
        current nullable:false, defaultValue: 0D
    }

    static mapping = {
        id generator: 'uuid'
    }

    Date dateCreated
    Date lastUpdated
}
