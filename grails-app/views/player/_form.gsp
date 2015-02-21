<%@ page import="com.cyrils.groupoloto.domain.Player" %>

<div class="form-group ${hasErrors(bean: playerInstance, field: 'lastname', 'has-error')}">

    <label for="lastname" class="col-sm-2 control-label"><g:message code="player.lastname.label"
                                                                    default="Lastname"/> *</label>

    <div class="col-sm-10">
        <div class="input-group">
            <span class="input-group-addon"><span
                    class="glyphicon glyphicon-user"></span></span>
            <g:textField name="lastname" required="" value="${playerInstance?.lastname}" class="form-control"/>
        </div>
        <div class="help-block with-errors"></div>
    </div>
</div>

<div class="form-group ${hasErrors(bean: playerInstance, field: 'firstname', 'has-error')}">

    <label for="firstname" class="col-sm-2 control-label"><g:message code="player.firstname.label"
                                                                     default="Firstname"/> *</label>

    <div class="col-sm-10">
        <div class="input-group">
            <span class="input-group-addon"><span
                    class="glyphicon glyphicon-user"></span></span>

            <g:textField name="firstname" required="" value="${playerInstance?.firstname}" class="form-control"/>
        </div>
        <div class="help-block with-errors"></div>
    </div>
</div>


<div class="form-group ${hasErrors(bean: playerInstance, field: 'email', 'has-error')}">

    <label for="email" class="col-sm-2 control-label"><g:message code="player.email.label"
                                                                 default="Email"/> *</label>

    <div class="col-sm-10">
        <div class="input-group">
            <span class="input-group-addon">@</span>
            <g:textField type="email" name="email" required="" value="${playerInstance?.email}" class="form-control"/>
        </div>
        <div class="help-block with-errors"></div>
    </div>
</div>

<g:hiddenField name="sessionId" value="${sessionId}"/>