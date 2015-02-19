package com.cyrils.groupoloto.domain

class Player {

    static belongsTo = [Session]

    String id

    String lastname
    String firstname
    String email

    static constraints = {
        lastname nullable:false, blank:false
        firstname nullable:false, blank:false
        email nullable:false, blank:false, email: true
    }

    static mapping = {
        id generator: 'uuid'
    }

    Date dateCreated
    Date lastUpdated
}
