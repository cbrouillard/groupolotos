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
                    code="mail.generator"/> <small>Un mail à envoyer ? Copiez-le. Ce programme a la flemme.</small>
            </h1>
            <hr/>
        </div>
        <g:if test="${flash.message}">
            <div class="alert alert-info" role="status">${flash.message}</div>
        </g:if>
    </div>
</div>

<div class="col-xs-12">

    <div class="panel panel-success">

        <div class="panel-heading">
            <h5><g:message code="${template}"/></h5>
        </div>

        <g:render template="/mail/${template}"/>

    </div>
</div>

</body>
</html>