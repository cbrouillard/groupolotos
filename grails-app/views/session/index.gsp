<%@ page import="com.cyrils.groupoloto.domain.Session" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'session.label', default: 'Session')}"/>

    <gvisualization:apiImport/>
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

<div class="col-sm-4 col-xs-12">

    <div class="panel panel-info">
        <div class="panel-heading">
            <h5><g:message code="stats.global"/></h5>
        </div>

        <table class="table">
            <tr>
                <td><strong>Nombre total de sessions</strong></td>
                <td>${com.cyrils.groupoloto.domain.Session.count()}</td>
            </tr>
            <tr class="warning">
                <td><strong>Banque, somme des en-cours</strong></td>
                <td><g:formatNumber number="${bank}" type="currency" currencyCode="EUR"/></td>
            </tr>
            <tr>
                <td><strong>Somme totale engagée</strong></td>
                <td><g:formatNumber number="${totalSum}" type="currency" currencyCode="EUR"/></td>
            </tr>
            <tr>
                <td><strong>Gains totaux engrangés</strong></td>
                <td><g:formatNumber number="${totalGains}" type="currency" currencyCode="EUR"/></td>
            </tr>
            <tr>
                <td><strong>Gains moyens par session</strong></td>
                <td><g:formatNumber number="${avgGains}" type="currency" currencyCode="EUR"/></td>
            </tr>
        </table>

    </div>

    <g:if test="${graphData}">
        <div class="panel panel-info">
            <div class="panel-heading">
                <h5><g:message code="stats.graph"/></h5>
            </div>

            <div class="panel-body">

                <%
                    def myDailyActivitiesColumns = [['string', 'Session'], ['number', message(code: 'fees')], ['number', message(code: 'gains')]]
                %>

                <gvisualization:areaCoreChart elementId="lineChart"
                                              columns="${myDailyActivitiesColumns}" data="${graphData}"
                                              legend="[position: 'bottom']"
                                              width="100%"/>
                <div id="lineChart"></div>

            </div>

        </div>
    </g:if>

</div>


<div class="col-sm-8 col-xs-12">

    <div class="panel panel-default">
        <div class="panel-heading">
            <sec:ifAllGranted roles="ROLE_ADMIN">
                <g:link controller="session" action="create" class="btn btn-success pull-right"><span
                        class="glyphicon glyphicon-plus"></span> <g:message
                        code="session.create"/></g:link>

                <h5>&nbsp;</h5>
            </sec:ifAllGranted>
        </div>

        <div class="table-responsive">
            <table class="table table-striped text-center">
                <thead>
                <tr>

                    <g:sortableColumn property="name" title="${message(code: 'session.name.label', default: 'Name')}"
                                      class="text-center"/>

                    <g:sortableColumn property="date" title="${message(code: 'session.date.label', default: 'Date')}"
                                      class="text-center"/>

                    <g:sortableColumn property="open" title="${message(code: 'session.open.label', default: 'Open')}"
                                      class="text-center"/>

                    <g:sortableColumn property="gains"
                                      title="${message(code: 'session.gains.label', default: 'Gains')}"
                                      class="text-center"/>

                    <g:sortableColumn property="dateCreated"
                                      title="${message(code: 'session.dateCreated.label', default: 'Date Created')}"
                                      class="text-center"/>

                </tr>
                </thead>
                <tbody>
                <g:each in="${sessionInstanceList}" status="i" var="sessionInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td><g:link action="show"
                                    id="${sessionInstance.id}">${fieldValue(bean: sessionInstance, field: 'name')}</g:link></td>

                        <td><g:formatDate date="${sessionInstance.date}" formatName="date.format.short"/></td>

                        <td class="text-center"><span
                                class="label label-${sessionInstance.open ? 'success' : 'danger'}"><g:formatBoolean
                                    boolean="${sessionInstance.open}"/></span></td>

                        <td><g:formatNumber number="${sessionInstance.gains}" type="currency" currencyCode="EUR"/></td>

                        <td><g:formatDate date="${sessionInstance.dateCreated}"/></td>

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
