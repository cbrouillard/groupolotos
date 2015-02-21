<table class="table">

    <tr>
        <td>
            <strong><g:message code="mail.persons"/></strong>
        </td>
        <td>
            ${emails}
        </td>
    </tr>

    <tr>
        <td>
            <strong><g:message code="mail.subject"/></strong>
        </td>
        <td>
            <g:message code="mail.gains.subject" args="[sessionInstance.name]"/>
        </td>
    </tr>

    <tr>
        <td>
            <strong><g:message code="mail.body"/></strong>
        </td>
        <td>
            <div class="well">
                Hello all,<br/><br/>

                La session '${sessionInstance.name}' a été cloturée, le tirage a eu lieu. Cette session reste accessible à cette url <g:link
                        absolute="true"
                        controller="session"
                        action="show"
                        id="${sessionInstance.id}">${createLink(absolute: true, controller: 'session', action: 'show', id: sessionInstance.id)}</g:link>.<br/>
                Nous avons remporté la fabuleuse somme de <strong><g:formatNumber number="${sessionInstance.gains}"
                                                                                  type="currency"
                                                                                  currencyCode="EUR"/></strong> à partager entre ${sessionInstance.players.size()} joueurs.
                <br/><br/>
                Ce qui nous donne donc un gain de : <strong><g:formatNumber
                    number="${sessionInstance.gains / sessionInstance.players.size()}" type="currency"
                    currencyCode="EUR"/></strong> par joueur. Votre en-cours a été mis à jour.
                <br/><br/>
                Et la citation du jour pour une meilleure journée :
                <script language="JavaScript"
                        src="http://citations.HasardDuJour.com/citation-hasard-du-jour.php?random&time=${new java.util.Date()}">
                </script>
            </div>
        </td>
    </tr>

</table>