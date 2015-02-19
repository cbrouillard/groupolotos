<%@ page import="com.cyrils.groupoloto.domain.Session" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'session.label', default: 'Session')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="row-fluid">
    <div class="col-xs-12">
        <div>
            <h1><g:message
                    code="session.show"/> <small>${sessionInstance.id} / ${sessionInstance.name}</small>
            </h1>
            <hr/>
        </div>

        <g:if test="${flash.message}">
            <div class="alert alert-info" role="status">${flash.message}</div>
        </g:if>
    </div>
</div>


<div class="col-xs-4">

    <div class="panel panel-default">
        <div class="panel-heading">

            <div class="form-inline pull-right">
                <g:form url="[resource: sessionInstance, action: 'delete']" method="DELETE"
                        class="form-inline pull-right">
                    <fieldset class="buttons">
                        <g:link class="btn btn-warning btn-sm" action="edit" resource="${sessionInstance}"><g:message
                                code="default.button.edit.label"
                                default="Edit"/></g:link>
                        <g:actionSubmit class="btn btn-danger btn-sm" action="delete"
                                        value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                    </fieldset>
                </g:form>
            </div>
            <h5><g:message code="session.infos"/> '${sessionInstance.name}'</h5>

            <div class="clearfix"></div>
        </div>

        <div class="panel-body">

            <table class="table table-condensed">

                <tr>
                    <td><strong><g:message code="session.date.label"
                                           default="Date"/></strong></td>
                    <td><g:formatDate
                            date="${sessionInstance?.date}"/></td>
                </tr>
                <tr>
                    <td><strong><g:message code="session.open.label"
                                           default="Open"/></strong></td>
                    <td><g:formatBoolean
                            boolean="${sessionInstance?.open}"/></td>
                </tr>
                <tr>
                    <td><strong><g:message code="session.dateCreated.label"
                                           default="Date Created"/></strong></td>
                    <td><g:formatDate
                            date="${sessionInstance?.dateCreated}"/></td>
                </tr>
                <tr>
                    <td><strong><g:message code="session.gains.label"
                                           default="Gains"/></strong></td>
                    <td><g:fieldValue bean="${sessionInstance}"
                                      field="gains"/></td>
                </tr>
                <tr>
                    <td><strong><g:message code="session.players.label"
                                           default="Players"/></strong></td>
                    <td></td>
                </tr>
            </table>

        </div>

    </div>

</div>

<div class="col-xs-8">
    <g:each in="${allPlayers}" var="player">
        ${player}<br/>
    </g:each>
</div>

</body>
</html>
