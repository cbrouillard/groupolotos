<%@ page import="com.cyrils.groupoloto.domain.security.SuperUser" %>

<div class="form-group ${hasErrors(bean: superUserInstance, field: 'username', 'has-error')}">

    <label for="username" class="col-sm-2 control-label"><g:message code="admin.username.label"
                                                                    default="username"/> *</label>

    <div class="col-sm-10">
        <div class="input-group">
            <span class="input-group-addon"><span
                    class="glyphicon glyphicon-user"></span></span>
            <g:textField name="username" required="" value="${superUserInstance?.username}" class="form-control"/>
        </div>
        <div class="help-block with-errors"></div>
    </div>
</div>

<div class="form-group ${hasErrors(bean: superUserInstance, field: 'password', 'has-error')}">

    <label for="password" class="col-sm-2 control-label"><g:message code="admin.password.label"
                                                                    default="password"/> *</label>

    <div class="col-sm-10">
        <div class="input-group">
            <span class="input-group-addon"><span
                    class="glyphicon glyphicon-star"></span></span>
            <g:passwordField name="password" required="" value="${superUserInstance?.password}" class="form-control"/>
        </div>
        <div class="help-block with-errors"></div>
    </div>
</div>

<div class="form-group ${hasErrors(bean: superUserInstance, field: 'email', 'has-error')}">

    <label for="email" class="col-sm-2 control-label"><g:message code="admin.email.label"
                                                                 default="email"/> *</label>

    <div class="col-sm-10">
        <div class="input-group">
            <span class="input-group-addon">@</span>
            <g:textField name="email" required="" value="${superUserInstance?.email}" class="form-control"/>
        </div>
        <div class="help-block with-errors"></div>
    </div>
</div>

<div class="form-group ${hasErrors(bean: superUserInstance, field: 'enabled', 'has-error')}">
    <div class="col-sm-offset-2 col-sm-10">
        <div class="checkbox">
            <label>
                <g:checkBox name="enabled" value="${superUserInstance?.enabled}"/> <g:message code="admin.enabled.label"
                                                                                              default="enabled"/>
            </label>
        </div>
    </div>
</div>