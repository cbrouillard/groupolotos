<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title><g:message code="app.title"/></title>
</head>

<body>

<g:if test='${flash.message}'>
    <div class='alert-info alert'>${flash.message}</div>
</g:if>


<div class="container">
    <form class="form-signin" action='${postUrl}' method='POST' id='loginForm' autocomplete='off'>

        <h2 class="form-signin-heading"><g:message code="login"/></h2>
        <label for="username" class="sr-only"><g:message code="user"/></label>
        <input type="text" name='j_username' id='username' class="form-control" placeholder="Votre id utilisateur"
               required
               autofocus>

        <label for="password" class="sr-only"><g:message code="password"/></label>
        <input type="password" name='j_password' id='password' class="form-control" placeholder="Votre mot de passe"
               required>

        <div class="checkbox">
            <label>
                <input type="checkbox" name='${rememberMeParameter}' id='remember_me'
                       <g:if test='${hasCookie}'>checked='checked'</g:if>/> <g:message code="remember.me"/>
            </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit"><g:message code="login"/></button>
    </form>

</div>
</body>
</html>