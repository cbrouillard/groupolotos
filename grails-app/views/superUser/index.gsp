<%@ page import="com.cyrils.groupoloto.domain.security.SuperUser" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'superUser.label', default: 'SuperUser')}"/>
</head>

<body>

<div class="row-fluid">
    <div class="col-xs-12">
        <div>
            <h1><g:message
                    code="admin.list"/> <small>22 v'la les admins !</small>
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
            <sec:ifAllGranted roles="ROLE_SUPERADMIN">
                <g:link action="create" class="btn btn-warning pull-right"><span
                        class="glyphicon glyphicon-user"></span> <g:message
                        code="admin.create"/></g:link>
                <h5>&nbsp;</h5>
            </sec:ifAllGranted>
        </div>

        <div class="panel-body">

            <g:set var="counter" value="${0}"/>
            <g:each in="${superUserInstanceList}" var="admin" status="index">
                <g:if test="${counter == 0}">
                    <div class="row-fluid">
                </g:if>
                <div class="col-xs-2">
                    <div class="thumbnail panel-success">
                        <img src="https://robohash.org/${admin.username}" width="100px"/>

                        <div class="caption text-center">
                            <ul class="list-group">
                                <li class="list-group-item list-group-item-success"><strong>${admin.username}</strong></li>
                                <li class="list-group-item">${admin.email}</li>
                                <sec:ifAllGranted roles="ROLE_ADMIN">
                                    <g:if test="${sec.loggedInUserInfo(field: "username") == admin.username}">
                                        <li class="list-group-item">
                                            <div class="btn-group" role="group">

                                                <button type="button" class="btn btn-success" data-toggle="modal"
                                                        data-target="#passwordModal">
                                                    <span class="glyphicon glyphicon-star"></span>
                                                    Pass
                                                </button>
                                            </div>
                                        </li>
                                    </g:if>
                                    <g:else>
                                        <li class="list-group-item">
                                            <button type="button" class="btn btn-success disabled">
                                                <span class="glyphicon glyphicon-star"></span>Pass
                                            </button>
                                        </li>
                                    </g:else>

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
            <g:paginate total="${superUserInstanceCount ?: 0}"/>
        </div>
    </div>
</div>

<g:render template="changepass"/>

</body>
</html>
