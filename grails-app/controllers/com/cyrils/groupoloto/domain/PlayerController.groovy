package com.cyrils.groupoloto.domain


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured

@Transactional(readOnly = true)
class PlayerController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 24, 100)
        params.sort = "firstname"
        params.order = "asc"
        respond Player.list(params), model: [playerInstanceCount: Player.count()]
    }

    def show(Player playerInstance) {
        respond playerInstance
    }

    @Secured(['ROLE_ADMIN'])
    def create() {
        [playerInstance: new Player(params), sessionId: params.session]
    }

    @Secured(['ROLE_ADMIN'])
    @Transactional
    def givemoney() {
        Player player = Player.get(params.id)
        if (player) {

            if (player.current != 0D){
                // todo envoyer un mail
            }

            player.current = 0D
            player.save flush: true
        }

        redirect action: 'index'
        return
    }

    @Secured(['ROLE_ADMIN'])
    @Transactional
    def save(Player playerInstance) {
        if (playerInstance == null) {
            notFound()
            return
        }

        if (playerInstance.hasErrors()) {
            respond playerInstance.errors, view: 'create'
            return
        }

        playerInstance.save flush: true

        if (params.sessionId) {
            redirect controller: 'session', action: "show", id: params.sessionId
        } else {
            redirect(action: 'index')
        }
    }

    @Secured(['ROLE_ADMIN'])
    def edit(Player playerInstance) {
        respond playerInstance
    }

    @Secured(['ROLE_ADMIN'])
    @Transactional
    def update(Player playerInstance) {
        if (playerInstance == null) {
            notFound()
            return
        }

        if (playerInstance.hasErrors()) {
            respond playerInstance.errors, view: 'edit'
            return
        }

        playerInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Player.label', default: 'Player'), playerInstance.id])
                redirect playerInstance
            }
            '*' { respond playerInstance, [status: OK] }
        }
    }

    @Secured(['ROLE_ADMIN'])
    @Transactional
    def delete(Player playerInstance) {

        if (playerInstance == null) {
            notFound()
            return
        }

        playerInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Player.label', default: 'Player'), playerInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'player.label', default: 'Player'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
