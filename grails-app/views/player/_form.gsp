<%@ page import="com.cyrils.groupoloto.domain.Player" %>



<div class="fieldcontain ${hasErrors(bean: playerInstance, field: 'lastname', 'error')} required">
	<label for="lastname">
		<g:message code="player.lastname.label" default="Lastname" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="lastname" required="" value="${playerInstance?.lastname}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: playerInstance, field: 'firstname', 'error')} required">
	<label for="firstname">
		<g:message code="player.firstname.label" default="Firstname" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="firstname" required="" value="${playerInstance?.firstname}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: playerInstance, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="player.email.label" default="Email" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="email" name="email" required="" value="${playerInstance?.email}"/>

</div>

