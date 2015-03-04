<%@ page import="com.cyrils.groupoloto.domain.Groupo" %>


<div class="form-group ${hasErrors(bean: groupoInstance, field: 'name', 'has-error')} required">

    <label for="name" class="col-sm-2 control-label"><g:message code="groupo.name.label"
                                                                default="Name"/> *</label>

    <div class="col-sm-10">
        <div class="input-group">
            <span class="input-group-addon"><span
                    class="glyphicon glyphicon-user"></span></span>
            <g:textField name="name" required="true" value="${groupoInstance?.name}" class="form-control"/>
        </div>
        <div class="help-block with-errors"></div>
    </div>
</div>

<div class="form-group required">

    <label for="name" class="col-sm-2 control-label"><g:message code="groupo.superemail.label"
                                                                default="Admin email"/> *</label>

    <div class="col-sm-10">
        <div class="input-group">
            <span class="input-group-addon"><span
                    class="glyphicon glyphicon-envelope"></span></span>
            <g:textField name="superEmail" required="true" value="${params.get('superEmail')}" class="form-control"/>
        </div>
        <div class="help-block with-errors"></div>
    </div>
</div>

