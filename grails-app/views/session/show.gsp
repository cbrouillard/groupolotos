<%@ page import="com.cyrils.groupoloto.domain.Session" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'session.label', default: 'Session')}"/>
</head>

<body>

<div class="row-fluid">
    <div class="col-sm-12">
        <div>
            <h1><g:message
                    code="session.show"/> <small>${sessionInstance.name}</small>
            </h1>
            <hr/>
        </div>

        <g:if test="${flash.message}">
            <div class="alert alert-info" role="status">${flash.message}</div>
        </g:if>
    </div>
</div>


<div class="col-sm-4 col-xs-12">

    <div class="panel panel-info">
        <div class="panel-heading">
            <sec:ifAllGranted roles="ROLE_ADMIN">
                <div class="form-inline pull-right">
                    <g:form url="[resource: sessionInstance, action: 'delete']" method="DELETE"
                            class="form-inline pull-right">
                        <fieldset class="buttons">
                            %{--<g:link class="btn btn-warning" action="edit" resource="${sessionInstance}">
                                <span class="glyphicon glyphicon-edit"></span> <g:message
                                    code="default.button.edit.label"
                                    default="Edit"/></g:link>--}%
                            <g:actionSubmit class="btn btn-danger" action="delete"
                                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                        </fieldset>
                    </g:form>
                </div>
            </sec:ifAllGranted>
            <h5><g:message code="session.infos"/> '${sessionInstance.name}'</h5>

            <div class="clearfix"></div>
        </div>

        <table class="table">

            <tr>
                <td><strong><g:message code="session.date.label"
                                       default="Date"/></strong></td>
                <td><g:formatDate
                        date="${sessionInstance?.date}"/></td>
                <td></td>
            </tr>
            <tr>
                <td><strong><g:message code="session.open.label"
                                       default="Open"/></strong></td>
                <td><g:formatBoolean
                        boolean="${sessionInstance?.open}"/></td>
                <td class="text-right">
                    <sec:ifAllGranted roles="ROLE_ADMIN">
                        <g:if test="${sessionInstance.open}">
                            <g:link class="btn btn-warning btn-xs" action="close" controller="session"
                                    id="${sessionInstance.id}"><span
                                    class="glyphicon glyphicon-stop"></span>
                                <g:message code="session.close"/>
                            </g:link>
                        </g:if>
                        <g:else>
                            <g:link class="btn btn-warning btn-xs" action="open" controller="session"
                                    id="${sessionInstance.id}"><span
                                    class="glyphicon glyphicon-play"></span>
                                <g:message code="session.open"/>
                            </g:link>
                        </g:else>
                    </sec:ifAllGranted>
                </td>
            </tr>
            <tr>
                <td><strong><g:message code="session.dateCreated.label"
                                       default="Date Created"/></strong></td>
                <td><g:formatDate
                        date="${sessionInstance?.dateCreated}"/></td>
                <td></td>
            </tr>
            <tr>
                <td><strong><g:message code="session.gains.label"
                                       default="Gains"/></strong></td>
                <td>
                    <g:if test="${sessionInstance.open}">
                        -
                    </g:if>
                    <g:else>
                        <g:fieldValue bean="${sessionInstance}"
                                      field="gains"/>
                    </g:else>
                    €
                </td>

                <td class="text-right">
                    <sec:ifAllGranted roles="ROLE_ADMIN">
                        <g:if test="${!sessionInstance.open}">
                            <button type="button" class="btn btn-success btn-xs" data-toggle="modal"
                                    data-target="#gainsModal">
                                <span
                                        class="glyphicon glyphicon-euro"></span>
                                <g:message code="session.gains"/>
                            </button>
                        </g:if>
                    </sec:ifAllGranted>

                </td>
            </tr>
        </table>
    </div>

    <div class="panel panel-info">
        <div class="panel-heading">
            <g:message code="session.players.label"
                       default="Players"/>
            <span class="badge">${sessionInstance.players?.size()}</span>
        </div>

        <table class="table">
            <g:each in="${sessionInstance.players}" var="player">
                <tr>
                    <td>${player.firstname} ${player.lastname}</td>
                    <td>${player.email}</td>
                    <td class="text-right">
                        <sec:ifAllGranted roles="ROLE_ADMIN">
                            <g:link controller="session" action="removeplayer" class="btn btn-danger btn-xs"
                                    params="[session: sessionInstance.id]" id="${player.id}">
                                <span class="glyphicon glyphicon-erase"></span>
                            </g:link>
                        </sec:ifAllGranted>
                    </td>
                </tr>
            </g:each>
        </table>

    </div>

</div>

<div class="col-sm-8 col-xs-12">

    <div class="panel panel-default">
        <div class="panel-heading">
            <sec:ifAllGranted roles="ROLE_ADMIN">
                <g:link class="btn btn-success pull-right" action="create" controller="player"
                        params="[session: sessionInstance.id]"><span
                        class="glyphicon glyphicon-user"></span>
                    <g:message code="player.add"/></g:link>
            </sec:ifAllGranted>
            <h5><g:message code="session.potentials.players"/></h5>

        </div>

        <div class="panel-body" style="background-color: transparent !important;">

            <g:set var="size" value="${allPlayers?.size()}"/>
            <g:set var="counter" value="${0}"/>
            <g:each in="${allPlayers}" var="player" status="index">
                <g:if test="${counter == 0}">
                    <div class="row-fluid">
                </g:if>
                <div class="col-lg-3 col-md-4 col-sm-5">
                    <div class="thumbnail panel-primary">
                        <img src="https://robohash.org/${player.firstname}${player.lastname.substring(0, 1)}"
                             width="100px"/>

                        <div class="caption text-center">
                            <sec:ifAllGranted roles="ROLE_ADMIN">
                                <g:if test="${sessionInstance.open}">
                                    <ul class="list-group">
                                        <li class="list-group-item list-group-item-info">

                                            <g:link controller="session" action="addplayer" class="btn btn-primary"
                                                    params="[session: sessionInstance.id]" id="${player.id}">
                                                <<< <strong>${player.firstname} ${player.lastname}</strong>
                                            </g:link>
                                        </li>
                                        <li class="list-group-item">

                                            <g:if test="${player.current < 2}">
                                                Somme dûe pour jouer : <g:formatNumber
                                                    number="${2 - player.current}"/> €
                                            </g:if>
                                            <g:else>
                                                En-cours suffisant
                                            </g:else>
                                        </li>
                                    </ul>

                                </g:if>
                                <g:else>
                                    <ul class="list-group">
                                        <li class="list-group-item">
                                            <strong>${player.firstname} ${player.lastname}</strong>
                                        </li>
                                    </ul>
                                </g:else>
                            </sec:ifAllGranted>

                            <sec:ifNotGranted roles="ROLE_ADMIN">
                                <ul class="list-group">
                                    <li class="list-group-item">
                                        <strong>${player.firstname} ${player.lastname}</strong>
                                    </li>
                                </ul>
                            </sec:ifNotGranted>

                        </div>
                    </div>
                </div>

                <g:if test="${counter == 0}">
                    </div>
                </g:if>
                <g:set var="counter" value="${counter + 1}"/>
                <g:if test="${counter >= 4}">
                    <g:set var="counter" value="${0}"/>
                </g:if>
            </g:each>
        </div>
    </div>

</div>

<g:render template="savegains"/>

</body>
</html>
