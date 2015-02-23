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

            <div class="btn-group">
                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown"
                        aria-expanded="false">
                    Tri <span class="caret"></span>
                </button>
                <ul class="dropdown-menu" role="menu">
                    <li><g:link controller="player" action="index"
                                params="[order: params.order == 'asc' ? 'desc' : 'asc', sort: 'firstname']">
                        <span
                                class="glyphicon glyphicon-sort-by-alphabet"></span> prénom
                    </g:link></li>
                    <li><g:link controller="player" action="index"
                                params="[order: params.order == 'asc' ? 'desc' : 'asc', sort: 'current']">
                        <span
                                class="glyphicon glyphicon-sort-by-attributes"></span> en-cours
                    </g:link></li>
                </ul>
            </div>
            Total : ${playerInstanceCount}

            <div class="btn-group pull-right" role="group">
                <sec:ifAllGranted roles="ROLE_ADMIN">
                    <g:link action="create" class="btn btn-success "><span
                            class="glyphicon glyphicon-user"></span> <g:message
                            code="player.create"/></g:link>
                </sec:ifAllGranted>

            </div>

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
                                <sec:ifAllGranted roles="ROLE_ADMIN">
                                    <li class="list-group-item list-group-item-info"><strong>${player.firstname} ${player.lastname}</strong>
                                    </li>

                                    <li class="list-group-item">${player.email}</li>
                                </sec:ifAllGranted>
                                <sec:ifNotGranted roles="ROLE_ADMIN">
                                    <li class="list-group-item list-group-item-info"><strong>${player.firstname} ${player.lastname.substring(0, 1)}.</strong>
                                    </li>
                                </sec:ifNotGranted>
                                <li class="list-group-item">En-cours : <g:formatNumber
                                        number="${player.current}" type="currency" currencyCode="EUR"/></li>
                                <sec:ifAllGranted roles="ROLE_ADMIN">
                                    <li class="list-group-item">
                                        <g:form url="[resource: player, action: 'delete']" method="DELETE">
                                            <div class="btn-group" role="group">
                                                <g:link class="btn btn-warning" action="givemoney" controller="player"
                                                        id="${player.id}">
                                                    <span class="glyphicon glyphicon-euro"></span>
                                                </g:link>

                                                <g:link class="btn btn-success" action="edit" controller="player"
                                                        id="${player.id}">
                                                    <span class="glyphicon glyphicon-edit"></span>
                                                </g:link>

                                                <button type="submit" class="btn btn-danger"
                                                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                                                    <span class="glyphicon glyphicon-trash"></span>
                                                </button>
                                            </div>
                                        </g:form>
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
