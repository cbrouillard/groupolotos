
<%@ page import="com.cyrils.groupoloto.domain.Player" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'player.label', default: 'Player')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-player" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-player" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="lastname" title="${message(code: 'player.lastname.label', default: 'Lastname')}" />
					
						<g:sortableColumn property="firstname" title="${message(code: 'player.firstname.label', default: 'Firstname')}" />
					
						<g:sortableColumn property="email" title="${message(code: 'player.email.label', default: 'Email')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'player.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'player.lastUpdated.label', default: 'Last Updated')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${playerInstanceList}" status="i" var="playerInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${playerInstance.id}">${fieldValue(bean: playerInstance, field: "lastname")}</g:link></td>
					
						<td>${fieldValue(bean: playerInstance, field: "firstname")}</td>
					
						<td>${fieldValue(bean: playerInstance, field: "email")}</td>
					
						<td><g:formatDate date="${playerInstance.dateCreated}" /></td>
					
						<td><g:formatDate date="${playerInstance.lastUpdated}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${playerInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
