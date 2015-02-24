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
                <g:message code="mail.everyone.subject" args="[sessionInstance.name]"/>
            </td>
        </tr>

        <tr>
            <td>
                <strong><g:message code="mail.body"/></strong>
            </td>
            <td>
                <div class="well">
                    Hello all,<br/><br/>

                    Une session a été créée sur Groupoloto, elle est accessible à cette url <g:link absolute="true"
                                                                                                    controller="session"
                                                                                                    action="show"
                                                                                                    id="${sessionInstance.id}">${createLink(absolute: true, controller: 'session', action: 'show', id: sessionInstance.id)}</g:link>.<br/>
                    La date du tirage pour cette session est prévue le <strong><g:formatDate formatName="date.format.long"
                                                                                     date="${sessionInstance.date}"/></strong>. Si vous souhaitez participer, passez au bureau de l'admin Groupoloto afin de valider votre inscription.<br/>
                    <br/>
                    Bientôt millionaires !
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