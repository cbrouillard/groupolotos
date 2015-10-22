package com.cyrils.groupoloto.domain

class Bank {

    String name
    Double leftOver = 0

    static constraints = {
        name nullable:false
        leftOver nullable:false
    }
}
