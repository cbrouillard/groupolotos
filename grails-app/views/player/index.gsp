<%@ page import="com.cyrils.groupoloto.domain.Player" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'player.label', default: 'Player')}"/>
</head>

<body>

<div class="row-fluid">
    <div class="col-sm-12">
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


<div class="col-sm-12">

    <div class="panel panel-default">
        <div class="panel-heading">
            <sec:ifAllGranted roles="ROLE_ADMIN">
                <g:link action="create" class="btn btn-success pull-right"><span
                        class="glyphicon glyphicon-user"></span> <g:message
                        code="player.create"/></g:link>
                <h5>&nbsp;</h5>
            </sec:ifAllGranted>
        </div>

        <div class="panel-body">

            <g:set var="counter" value="${0}"/>
            <g:each in="${playerInstanceList}" var="player" status="index">
                <g:if test="${counter == 0}">
                    <div class="row-fluid">
                </g:if>
                <div class="col-lg-2 col-md-4 col-sm-5">
                    <div class="thumbnail panel-primary">
                        <img src="https://robohash.org/${player.firstname}${player.lastname.substring(0, 1)}"
                             width="100px"/>

                        <div class="caption text-center">
                            <ul class="list-group">
                                <li class="list-group-item list-group-item-info"><strong>${player.firstname} ${player.lastname}</strong>
                                </li>
                                <li class="list-group-item">${player.email}</li>
                                <li class="list-group-item">En-cours : <g:formatNumber
                                        number="${player.current}"/> €</li>
                                <sec:ifAllGranted roles="ROLE_ADMIN">
                                    <li class="list-group-item">
                                        <g:link class="btn btn-danger" action="givemoney" controller="player"
                                                id="${player.id}">
                                            <span class="glyphicon glyphicon-euro"></span> <g:message
                                                code="player.give.money"/>
                                        </g:link>

                                    </li>
                                </sec:ifAllGranted>
                            </ul>

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
