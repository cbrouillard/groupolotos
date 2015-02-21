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

    <label for="dateToParse" class="col-sm-2 control-label"><g:message code="session.date.label"
                                                                default="date"/> *</label>

    <div class="col-sm-10">
        <div class="input-group">
            <span class="input-group-addon"><span
                    class="glyphicon glyphicon-calendar"></span></span>
            <g:textField name="dateToParse" value="${formatDate(date: sessionInstance.date, formatName: 'date.format.short')}"
                         class="form-control datepicker"/>
        </div>

        <div class="help-block with-errors"></div>
    </div>
</div>

