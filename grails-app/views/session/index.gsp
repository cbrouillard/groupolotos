<%@ page import="com.cyrils.groupoloto.domain.Session" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'session.label', default: 'Session')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div class="row-fluid">
    <div class="col-xs-12">
        <div>
            <h1><g:message
                    code="session.list"/> <small>Toutes vos sessions de jeu en cours ou terminées sont ici.</small>
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
            <g:link controller="session" action="create" class="btn btn-success btn-xs pull-right"><span
                    class="glyphicon glyphicon-euro"></span> <g:message
                    code="session.create"/></g:link>
        &nbsp;
        </div>

        <div class="panel-body">

            <table class="table table-striped">
                <thead>
                <tr>

                    <g:sortableColumn property="date" title="${message(code: 'session.date.label', default: 'Date')}"/>

                    <g:sortableColumn property="open" title="${message(code: 'session.open.label', default: 'Open')}"/>

                    <g:sortableColumn property="gains"
                                      title="${message(code: 'session.gains.label', default: 'Gains')}"/>

                    <g:sortableColumn property="dateCreated"
                                      title="${message(code: 'session.dateCreated.label', default: 'Date Created')}"/>

                    <g:sortableColumn property="lastUpdated"
                                      title="${message(code: 'session.lastUpdated.label', default: 'Last Updated')}"/>

                </tr>
                </thead>
                <tbody>
                <g:each in="${sessionInstanceList}" status="i" var="sessionInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td><g:link action="show"
                                    id="${sessionInstance.id}">${fieldValue(bean: sessionInstance, field: "date")}</g:link></td>

                        <td><g:formatBoolean boolean="${sessionInstance.open}"/></td>

                        <td>${fieldValue(bean: sessionInstance, field: "gains")}</td>

                        <td><g:formatDate date="${sessionInstance.dateCreated}"/></td>

                        <td><g:formatDate date="${sessionInstance.lastUpdated}"/></td>

                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>

        <div class="panel-footer">
            <g:paginate total="${sessionInstanceCount ?: 0}"/>
        </div>
    </div>
</div>

</body>
</html>
