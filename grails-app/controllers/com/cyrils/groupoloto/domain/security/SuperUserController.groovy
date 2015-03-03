package com.cyrils.groupoloto.domain.security

import com.cyrils.groupoloto.domain.Groupo

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
@Transactional(readOnly = true)
class SuperUserController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService

    def cookieService

    // Must have a groupoid in cookie (mandatory)
    def beforeInterceptor = {
        def groupoid = cookieService.getCookie("groupoid")
        println "Tracing action ${actionUri} groupoid: ${groupoid}"
        if (!groupoid) {
            // No groupoid => go to index
            redirect controller: 'index', action: 'index'
            return false;
        }
        return true;
    }

    def index(Integer max) {
        Groupo groupo = Groupo.findById(cookieService.getCookie("groupoid"))
        Map<String, Object> queryParams = ['groupo': groupo]

        params.max = Math.min(max ?: 6, 100)
        params.sort = "username"
        params.order = "asc"
        respond SuperUser.findAllWhere(queryParams, params), model:[superUserInstanceCount: SuperUser.countByGroupo(groupo)]
    }

    @Secured(['ROLE_SUPERADMIN'])
    def create() {
        respond new SuperUser(params)
    }

    @Transactional
    def changepass(){
        def pass = params.password
        def confirmation = params.passwordCheck

        if (pass != confirmation){
            // should not happen
            redirect action:'index'
            return
        }

        SuperUser user = springSecurityService.currentUser
        user.password = pass
        user.save flush:true
        flash.message = message(code:'password.changed')
        chain(action: "index")
        return
    }

    @Secured(['ROLE_SUPERADMIN'])
    @Transactional
    def save(SuperUser superUserInstance) {
        if (superUserInstance == null) {
            notFound()
            return
        }

        if (superUserInstance.hasErrors()) {
            if (superUserInstance.getErrors().errorCount == 1
                    && superUserInstance.getErrors().hasFieldErrors("groupo")) {
                // Skip this error
            } else {
                respond superUserInstance.errors, view: 'create'
                return
            }
        }

        def pass = params.password
        def confirmation = params.passwordCheck
        if (pass != confirmation){
            // should not happen
            redirect action:'index'
            return
        }

        Groupo groupo = Groupo.findById(cookieService.getCookie("groupoid"))
        superUserInstance.groupo = groupo

        superUserInstance.save flush:true

        def roleAdmin = Role.findByAuthority("ROLE_ADMIN")
        if (!roleAdmin) {
            // Should not happen
            roleAdmin = new Role(authority: "ROLE_ADMIN").save(flush: true)
        }
        SuperUserRole.create(superUserInstance, roleAdmin, true)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'superUser.label', default: 'SuperUser'), superUserInstance.id])
                redirect action: 'index'
            }
            '*' { respond superUserInstance, [status: CREATED] }
        }
    }

    @Secured(['ROLE_SUPERADMIN'])
    @Transactional
    def delete(SuperUser superUserInstance) {

        if (superUserInstance == null) {
            notFound()
            return
        }

        SuperUserRole.removeAll(superUserInstance, true)
        superUserInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'SuperUser.label', default: 'SuperUser'), superUserInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'superUser.label', default: 'SuperUser'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
