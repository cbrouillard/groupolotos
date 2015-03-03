package com.cyrils.groupoloto.domain

import grails.transaction.Transactional

import javax.servlet.http.Cookie

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class IndexController {

    // Using Cookie service DI
    def cookieService

    def index() {
        // Groupolotos entry point

        // Looking for a group
        def groupoToGo = null
        if (params.id) {
            groupoToGo = Groupo.findById(params.id)
        } else {
            // If Default Group enable => use it
            groupoToGo = Groupo.findByName("_DEFAULT_");
        }

        if (groupoToGo && groupoToGo.enable) {
            // Redirect to group
            cookieService.setCookie("groupoid", groupoToGo.id);
            redirect controller: 'session', action: 'index'
        } else {
            // Nothing => must go to create groupo form
            redirect controller: 'groupo', action: 'create'
        }
    }

    def denied() {
        // Access denied

    }
}
