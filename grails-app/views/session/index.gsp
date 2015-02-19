
<%@ page import="com.cyrils.groupoloto.domain.Session" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'session.label', default: 'Session')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-session" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-session" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="date" title="${message(code: 'session.date.label', default: 'Date')}" />
					
						<g:sortableColumn property="open" title="${message(code: 'session.open.label', default: 'Open')}" />
					
						<g:sortableColumn property="gains" title="${message(code: 'session.gains.label', default: 'Gains')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'session.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'session.lastUpdated.label', default: 'Last Updated')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${sessionInstanceList}" status="i" var="sessionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${sessionInstance.id}">${fieldValue(bean: sessionInstance, field: "date")}</g:link></td>
					
						<td><g:formatBoolean boolean="${sessionInstance.open}" /></td>
					
						<td>${fieldValue(bean: sessionInstance, field: "gains")}</td>
					
						<td><g:formatDate date="${sessionInstance.dateCreated}" /></td>
					
						<td><g:formatDate date="${sessionInstance.lastUpdated}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${sessionInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
