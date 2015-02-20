<%@ page import="com.cyrils.groupoloto.domain.Player" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'player.label', default: 'Player')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div class="row-fluid">
    <div class="col-xs-12">
        <div>
            <h1><g:message
                    code="players.list"/> <small>Voici la liste publique des joueurs enregistrés</small>
            </h1>
            <hr/>
        </div>
        <g:if test="${flash.message}">
            <div class="alert alert-info" role="status">${flash.message}</div>
        </g:if>
    </div>
</div>


<div class="col-xs-12">

    <div class="panel panel-default">
        <div class="panel-heading">
            <g:link action="create" class="btn btn-success pull-right"><span
                    class="glyphicon glyphicon-user"></span> <g:message
                    code="player.create"/></g:link>
            <h5>&nbsp;</h5>
        </div>

        <div class="panel-body">

            <g:set var="counter" value="${0}"/>
            <g:each in="${playerInstanceList}" var="player" status="index">
                <g:if test="${counter == 0}">
                    <div class="row-fluid">
                </g:if>
                <div class="col-xs-2">
                    <div class="thumbnail panel-primary">
                        <img src="https://robohash.org/${player.firstname}${player.lastname.substring(0, 1)}"
                             width="100px"/>

                        <div class="caption text-center">
                            <strong>${player.firstname} ${player.lastname}</strong>
                        </div>
                    </div>
                </div>

                <g:if test="${counter == 0}">
                    </div>
                </g:if>
                <g:set var="counter" value="${counter + 1}"/>
                <g:if test="${counter >= 6}">
                    <g:set var="counter" value="${0}"/>
                </g:if>
            </g:each>
        </div>

        <div class="panel-footer">
            <g:paginate total="${playerInstanceCount ?: 0}"/>
        </div>

    </div>
</div>
</body>
</html>
