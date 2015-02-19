
<%@ page import="com.cyrils.groupoloto.domain.Session" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'session.label', default: 'Session')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-session" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-session" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list session">
			
				<g:if test="${sessionInstance?.date}">
				<li class="fieldcontain">
					<span id="date-label" class="property-label"><g:message code="session.date.label" default="Date" /></span>
					
						<span class="property-value" aria-labelledby="date-label"><g:formatDate date="${sessionInstance?.date}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.open}">
				<li class="fieldcontain">
					<span id="open-label" class="property-label"><g:message code="session.open.label" default="Open" /></span>
					
						<span class="property-value" aria-labelledby="open-label"><g:formatBoolean boolean="${sessionInstance?.open}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.gains}">
				<li class="fieldcontain">
					<span id="gains-label" class="property-label"><g:message code="session.gains.label" default="Gains" /></span>
					
						<span class="property-value" aria-labelledby="gains-label"><g:fieldValue bean="${sessionInstance}" field="gains"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="session.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${sessionInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="session.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${sessionInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${sessionInstance?.players}">
				<li class="fieldcontain">
					<span id="players-label" class="property-label"><g:message code="session.players.label" default="Players" /></span>
					
						<g:each in="${sessionInstance.players}" var="p">
						<span class="property-value" aria-labelledby="players-label"><g:link controller="player" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:sessionInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${sessionInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>

        <g:each in="${allPlayers}" var="player">
            ${player}<br/>
        </g:each>

	</body>
</html>
