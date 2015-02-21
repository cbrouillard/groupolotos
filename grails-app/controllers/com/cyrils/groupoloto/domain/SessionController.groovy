package com.cyrils.groupoloto.domain


import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

import grails.plugin.springsecurity.annotation.Secured

@Transactional(readOnly = true)
class SessionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        params.sort = "date"
        params.order = "desc"

        def c = Session.createCriteria()
        def gainsSum = c.get {
            projections {
                sum "gains"
            }
        }

        def c2 = Session.createCriteria()
        def gainsAvg = c2.get {
            projections {
                avg "gains"
            }
        }

        def playersCount = Session.executeQuery(
                'select count(p.id) from Session s join s.players p')[0]

        def graphResult = Session.executeQuery(
                'select s.name, count(p) * 2, s.gains from Session s join s.players p group by s.name, s.gains'
        )

        respond Session.list(params), model: [sessionInstanceCount: Session.count(),
                                              totalGains          : gainsSum,
                                              totalSum            : playersCount * 2,
                                              avgGains            : gainsAvg,
                                              graphData           : graphResult]
    }

    def show(Session sessionInstance) {

        def allPlayers = Player.findAll();
        allPlayers.removeAll(sessionInstance.players)

        [sessionInstance: sessionInstance, allPlayers: allPlayers]
    }

    @Secured(['ROLE_ADMIN'])
    def create() {
        respond new Session(params)
    }

    @Secured(['ROLE_ADMIN'])
    @Transactional
    def addplayer() {

        Player player = Player.findById(params.id)
        Session session = Session.findById(params.session)
        if (!player || !session) {
            redirect controller: 'session'
        } else {
            session.players.add(player)
            player.current -= 2
            if (player.current < 0) {
                player.current = 0
            }
            session.save flush: true
            redirect action: 'show', id: session.id
        }

        return
    }

    @Secured(['ROLE_ADMIN'])
    @Transactional
    def removeplayer() {

        Player player = Player.findById(params.id)
        Session session = Session.findById(params.session)
        if (!player || !session) {
            redirect controller: 'session'
        } else {
            session.players.remove(player)
            // todo remettre l'en-cours à niveau de la participation
            session.save flush: true
            redirect action: 'show', id: session.id
        }

        return
    }

    @Secured(['ROLE_ADMIN'])
    @Transactional
    def close() {
        openOrClose(params.id, false)
        return
    }

    @Secured(['ROLE_ADMIN'])
    @Transactional
    def open() {
        openOrClose(params.id, true)
        return
    }

    private void openOrClose(def sessionId, boolean open) {
        Session session = Session.get(sessionId)
        if (!session) {
            redirect controller: 'session'
        } else {
            session.open = open
            session.save flush: true
            redirect action: 'show', id: session.id
        }

        return
    }

    @Secured(['ROLE_ADMIN'])
    @Transactional
    def win() {
        Session session = Session.findById(params.sessionId)
        if (session) {

            def previousSavedGains = new Double(session.gains)

            bindData(session, params, [include: ["gains"]])

            def players = session.players
            if (players) {
                def eachPlayersGains = new Double((session.gains - previousSavedGains) / players.size())
                players.each { p ->
                    p.current += eachPlayersGains
                }

                // todo envoyer un mail à tous les joueurs
            }

            session.save(flush: true)
            redirect action: 'show', id: session.id
            return
        }

        redirect action: 'index'
        return
    }

    @Secured(['ROLE_ADMIN'])
    @Transactional
    def save(Session sessionInstance) {
        if (sessionInstance == null) {
            notFound()
            return
        }

        if (sessionInstance.hasErrors()) {
            respond sessionInstance.errors, view: 'create'
            return
        }

        sessionInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'session.label', default: 'Session'), sessionInstance.id])
                redirect sessionInstance
            }
            '*' { respond sessionInstance, [status: CREATED] }
        }
    }

    @Secured(['ROLE_ADMIN'])
    @Transactional
    def delete(Session sessionInstance) {

        if (sessionInstance == null) {
            notFound()
            return
        }

        sessionInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Session.label', default: 'Session'), sessionInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'session.label', default: 'Session'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NOT_FOUND }
        }
    }
}
