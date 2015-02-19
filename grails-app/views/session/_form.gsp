<%@ page import="com.cyrils.groupoloto.domain.Session" %>

<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="session.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="date" precision="day"  value="${sessionInstance?.date}"  />

</div>


<div class="fieldcontain ${hasErrors(bean: sessionInstance, field: 'players', 'error')} ">
    <label for="players">
        <g:message code="session.players.label" default="Players" />

    </label>
    <g:select name="players" from="${com.cyrils.groupoloto.domain.Player.list()}"
              multiple="multiple" optionKey="id" size="5" value="${sessionInstance?.players*.id}" class="many-to-many"/>

</div>

