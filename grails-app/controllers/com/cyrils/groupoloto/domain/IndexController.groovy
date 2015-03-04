package com.cyrils.groupoloto.domain

import com.cyrils.groupoloto.domain.security.Role
import com.cyrils.groupoloto.domain.security.SuperUser
import com.cyrils.groupoloto.domain.security.SuperUserRole
import grails.transaction.Transactional

import javax.servlet.http.Cookie

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class IndexController {

    static allowedMethods = [save: "POST"]

    // Using Cookie service DI
    def cookieService

    def springSecurityService

    def index() {
        // Groupolotos entry point
        def groupoToGo = null

        // Logged user?
        SuperUser user = springSecurityService.currentUser
        if (user?.groupo?.id) {
            groupoToGo = user.groupo
        } else {
            // Looking for a group
            if (params.id) {
                groupoToGo = Groupo.findById(params.id)
            } else if (Groupo.count() == 1) {
                // If Default Group enable => use it
                groupoToGo = Groupo.findByName("_DEFAULT_");
            }
        }

        if (groupoToGo && groupoToGo.enable) {
            // Redirect to group
            cookieService.setCookie("groupoid", groupoToGo.id);
            redirect controller: 'session', action: 'index'
        } else {
            // Nothing => must go to create groupo form
            redirect action: 'create'
        }
    }

    def denied() {
        // Access denied

    }

    def create() {
        respond new Groupo(params)
    }

    @Transactional
    def save(Groupo groupoInstance) {
        if (groupoInstance == null) {
            notFound()
            return
        }

        if (groupoInstance.hasErrors()) {
            respond groupoInstance.errors, view:'create'
            return
        }

        groupoInstance.save flush:true

        def superEmail = params.get("superEmail")
        println "Tracing action create groupo ${actionUri} superEmail: ${superEmail}"

        // Create super user for this groupo
        def admin = new SuperUser()
        admin.accountExpired = false
        admin.accountLocked = false
        admin.email = superEmail
        admin.enabled = true
        admin.passwordExpired = false
        admin.username = superEmail
        admin.groupo = groupoInstance

        // TODO - generate password and send it by email
        admin.password = "admin"
        admin.save(flush: true)

        def roleAdmin = Role.findByAuthority("ROLE_ADMIN")
        def roleSuperAdmin = Role.findByAuthority("ROLE_SUPERADMIN")
        SuperUserRole.create(admin, roleAdmin, true)
        SuperUserRole.create(admin, roleSuperAdmin, true)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'groupo.label', default: 'Groupo'), groupoInstance.id])
                redirect action: 'created', id: groupoInstance.id
            }
            //'*' {redirect action: 'index', id: groupoInstance.id}
            '*' { respond groupoInstance, [status: CREATED] }
        }
    }

    def created() {

    }
}
