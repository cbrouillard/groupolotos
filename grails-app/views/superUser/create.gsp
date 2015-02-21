<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'superUser.label', default: 'SuperUser')}"/>
</head>

<body>

<div class="row-fluid">
    <div class="col-xs-12">
        <div>
            <h1><g:message
                    code="admin.create"/> <small><g:message code="admin.create.hint"/></small>
            </h1>
            <hr/>
        </div>

        <g:if test="${flash.message}">
            <div class="alert alert-info" role="status">${flash.message}</div>
        </g:if>

        <g:hasErrors bean="${superUserInstance}">
            <div class="alert alert-danger">
                <ul class="errors" role="alert">
                    <g:eachError bean="${superUserInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></li>
                    </g:eachError>
                </ul>
            </div>
        </g:hasErrors>
    </div>
</div>

<div class="col-xs-12">

    <g:form url="[resource: superUserInstance, action: 'save']" class="form-horizontal" data-toggle="validator">
        <div class="panel panel-default">
            <div class="panel-body">

                <fieldset class="form">
                    <g:render template="form"/>
                </fieldset>

            </div>

            <div class="panel-footer">

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">

                        <button type="submit" class="btn btn-success">
                            <span class="glyphicon glyphicon-save"></span> ${message(code: 'default.button.create.label', default: 'Save')}
                        </button>

                    </div>
                </div>
            </div>

        </div>

    </g:form>

</div>

</body>
</html>
