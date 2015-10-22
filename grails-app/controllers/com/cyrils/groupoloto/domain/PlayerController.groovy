package com.cyrils.groupoloto.domain


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured

@Transactional(readOnly = true)
class PlayerController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 24, 100)
        params.sort = params.sort ?: "firstname"
        params.order = params.order ?: "asc"
        respond Player.findAllByDeleted(false, params), model: [playerInstanceCount: Player.countByDeleted(false)]
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

            if (player.current != 0D) {
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
    def redistributeOldCash (){
        def eileo = Bank.findByName ("Eileo")
        def players = Player.findAllByDeleted(false)

        def amount = eileo.leftOver / players.size()
        players.each {player ->
            player.current += amount
            player.save()
        }

        eileo.leftOver = 0
        eileo.save(flush: true)

        redirect controller: 'session', action: 'index'
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

        // en dur pour le moment.
        def eileo = Bank.findByName ("Eileo")
        eileo.leftOver += playerInstance.current
        eileo.save(flush: true)

        // effacement virtuel
        playerInstance.deleted = true
        playerInstance.current = 0
        playerInstance.save(flush: true)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Player.label', default: 'Player'), playerInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    @Secured(['ROLE_ADMIN'])
    @Transactional
    def addmoney() {

        def player = Player.get(params.playerId)
        if (!player) {
            redirect action: 'index'
            return
        }

        def currentCurrent = player.current
        bindData(player, params, [include: ["current", "automationForNextGame"]])
        player.current += currentCurrent
        player.save flush: true

        if (params.redirection) {
            redirect controller: 'session', action: 'show', id: params.sessionId
        } else {
            redirect action: 'index'
        }
        return
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
