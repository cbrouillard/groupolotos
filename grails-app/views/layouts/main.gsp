<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:message code="app.title"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${assetPath(src: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${assetPath(src: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${assetPath(src: 'apple-touch-icon-retina.png')}">

    <asset:stylesheet src="application.css"/>
    <asset:javascript src="application.js"/>
    <g:layoutHead/>
</head>

<body>

<nav class="navbar navbar-default navbar-static-top" role="navigation">
    <div class="container-fluid">

        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target="#navbar-collapse-1">
                <span class="sr-only">Toggle</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>

            <g:link controller="session" action="index" class="navbar-brand" style="vertical-align:middle;">
                <g:message code="app.name"/></g:link>

        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="navbar-collapse-1">

            <ul class="nav navbar-nav navbar-right">

                <sec:ifAllGranted roles="ROLE_ADMIN">
                    <li class="navbar-text">
                        <span class="glyphicon glyphicon-heart"></span>
                        <g:message code="hello" args="${sec.loggedInUserInfo(field: "username")}"/>
                    </li>
                </sec:ifAllGranted>

                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span
                            class="glyphicon glyphicon-cog"></span> <g:message code="action.menu"/> <span
                            class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">

                        <li>
                            <g:link controller="session" action="index">
                                <span class="glyphicon glyphicon-euro"></span> <g:message code="session.list"/></g:link>
                        </li>
                        <sec:ifAllGranted roles="ROLE_ADMIN">
                            <li>
                                <g:link controller="session" action="create">
                                    <span class="glyphicon glyphicon-plus"></span> <g:message
                                        code="session.create"/></g:link>
                            </li>
                        </sec:ifAllGranted>

                        <li class="divider"></li>

                        <li>
                            <g:link controller="player" action="index">
                                <span class="glyphicon glyphicon-user"></span> <g:message code="player.list"/></g:link>
                        </li>


                        <li class="divider"></li>
                        <sec:ifAllGranted roles="ROLE_ADMIN">
                            <li><g:link controller="superUser" action="index"><span
                                    class="glyphicon glyphicon-list"></span> <g:message code="manage.admin"/></g:link>
                            </li>
                        </sec:ifAllGranted>

                        <sec:ifLoggedIn>

                            <li><g:link controller="logout" class="logout"><span
                                    class="glyphicon glyphicon-log-out"></span> <g:message code="logout"/></g:link>
                            </li>
                        </sec:ifLoggedIn>
                        <sec:ifNotLoggedIn>
                            <li><g:link controller="login" class="login"><span
                                    class="glyphicon glyphicon-log-in"></span> <g:message code="login"/></g:link>
                            </li>
                        </sec:ifNotLoggedIn>
                    </ul>
                </li>

            </ul>
        </div><!-- /.navbar-collapse -->

    </div><!-- /.container-fluid -->
</nav>

<div class="container-fluid">
    <g:layoutBody/>
</div>

<footer>
    <nav class="navbar navbar-default navbar-fixed-bottom" role="navigation">
        <div class="container-fluid">

            <div class="navbar-header">
                <g:link controller="session" action="index" class="navbar-brand" style="vertical-align:middle;">
                    <asset:image src="rastapopoulos.jpg" width="24px" style="float: left;"/>
                </g:link>
            </div>

            <ul class="nav navbar-nav navbar-right">
                <li class="navbar-text"><g:message code="app.name"/> - Application de gestion de loto à plusieurs</li>
                <li>
                    <a href="https://github.com/cbrouillard/groupolotos">https://github.com/cbrouillard/groupolotos</a>
                </li>
            </ul>
        </div>
    </nav>
</footer>

</body>
</html>
