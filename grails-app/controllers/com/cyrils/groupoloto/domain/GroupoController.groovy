package com.cyrils.groupoloto.domain

import com.cyrils.groupoloto.domain.security.Role
import com.cyrils.groupoloto.domain.security.SuperUser
import com.cyrils.groupoloto.domain.security.SuperUserRole

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class GroupoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Groupo.list(params), model:[groupoInstanceCount: Groupo.count()]
    }

    def show(Groupo groupoInstance) {
        respond groupoInstance
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
                redirect groupoInstance
            }
            '*' { respond groupoInstance, [status: CREATED] }
        }
    }

    def edit(Groupo groupoInstance) {
        respond groupoInstance
    }

    @Transactional
    def update(Groupo groupoInstance) {
        if (groupoInstance == null) {
            notFound()
            return
        }

        if (groupoInstance.hasErrors()) {
            respond groupoInstance.errors, view:'edit'
            return
        }

        groupoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Groupo.label', default: 'Groupo'), groupoInstance.id])
                redirect groupoInstance
            }
            '*'{ respond groupoInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Groupo groupoInstance) {

        if (groupoInstance == null) {
            notFound()
            return
        }

        groupoInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Groupo.label', default: 'Groupo'), groupoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'groupo.label', default: 'Groupo'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
