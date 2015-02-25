<div class="table-responsive">
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
                <g:message code="mail.closed.subject" args="[sessionInstance.name]"/>
            </td>
        </tr>

        <tr>
            <td>
                <strong><g:message code="mail.body"/></strong>
            </td>
            <td>
                <div class="well">
                    Hello all,<br/><br/>

                    La session '${sessionInstance.name}' a été cloturée, le tirage aura lieu prochainement. Cette session reste accessible à cette url <g:link
                            absolute="true"
                            controller="session"
                            action="show"
                            id="${sessionInstance.id}">${createLink(absolute: true, controller: 'session', action: 'show', id: sessionInstance.id)}</g:link>.<br/>
                    Vous pouvez télécharger le ticket de jeu à cette adresse : <g:link absolute="true" controller="session" action="downloadticket" id="${sessionInstance.id}">
                        ${createLink(absolute: true, controller: 'session', action:'downloadticket', id:sessionInstance.id)}
                    </g:link>.
                    <br/><br/>
                    May the force be with us !
                    <br/><br/>
                    Et la citation du jour pour une meilleure journée :
                    <script language="JavaScript"
                            src="http://citations.HasardDuJour.com/citation-hasard-du-jour.php?random&time=${new java.util.Date()}">
                    </script>
                </div>
            </td>
        </tr>

    </table>
</div>