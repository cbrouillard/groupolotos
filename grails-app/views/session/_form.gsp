<%@ page import="com.cyrils.groupoloto.domain.Session" %>

<div class="form-group ${hasErrors(bean: sessionInstance, field: 'name', 'has-error')}">

    <label for="name" class="col-sm-2 control-label"><g:message code="session.name.label"
                                                                default="Name"/> *</label>

    <div class="col-sm-10">
        <div class="input-group">
            <span class="input-group-addon"><span
                    class="glyphicon glyphicon-font"></span></span>
            <g:textField name="name" required="" value="${sessionInstance?.name}" class="form-control"/>
        </div>
        <div class="help-block with-errors"></div>
    </div>
</div>

<div class="form-group ${hasErrors(bean: sessionInstance, field: 'date', 'has-error')}">

    <label for="date" class="col-sm-2 control-label"><g:message code="session.date.label"
                                                                default="date"/> *</label>

    <div class="col-sm-10">
        <g:datePicker name="date" precision="day" value="${sessionInstance?.date}"/>
        <div class="help-block with-errors"></div>
    </div>
</div>

