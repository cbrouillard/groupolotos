
<%@ page import="com.cyrils.groupoloto.domain.Groupo" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'groupo.label', default: 'Groupo')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
    TODO - Votre groupo a bien été créé!!! BRABO :)
    <br>
    GO HO GO <g:link controller="index" id="${params.id}">${params.id}, C'est par ici ...</g:link>
	</body>
</html>
