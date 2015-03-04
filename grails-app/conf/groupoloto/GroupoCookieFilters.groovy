package groupoloto

import com.cyrils.groupoloto.domain.Groupo
import com.cyrils.groupoloto.domain.security.SuperUser
import grails.plugin.springsecurity.annotation.Secured

class GroupoCookieFilters {

    def cookieService

    def springSecurityService

    def grailsApplication

    def _checkGroupoCookie(actionUri, params, controllerName, actionName) {
        def groupoid = cookieService.getCookie("groupoid")
        println "Tracing action ${actionUri} groupoid: ${groupoid}"
        if (!groupoid) {
            return false;
        }
        Groupo groupo = Groupo.findById(groupoid)
        params.groupo = groupo

        if (controllerName) {
            // Get the instance of controller class from string value i.e; controllerName
            def controllerClass = grailsApplication.controllerClasses.find {it.logicalPropertyName == controllerName}

            // Read the annotation from controller class
            def annotation = controllerClass.clazz.getAnnotation(Secured)

            // Get the current action from actionName otherwise read default action of controller
            String currentAction = actionName ?: controllerClass.defaultActionName

            // Look for the annotation on action if controller is not annotated or the action name is excluded
            if (!annotation) { /*  || currentAction in annotation.exclude() */
                // Get the action method
                def action = grailsApplication.mainContext.getBean(controllerClass.fullName).class.declaredMethods.find { method -> method.name == currentAction }
                if (action == null) {
                    // Get the action field from string value i.e; currentAction
                    action = grailsApplication.mainContext.getBean(controllerClass.fullName).class.declaredFields.find { field -> field.name == currentAction }
                }
                // If action is found get the annotation else set it to null
                annotation = action ? action.getAnnotation(Secured) : null
            }

            println "annotation: ${annotation}"
            if (annotation) {
                // Check Admin right
                SuperUser user = springSecurityService.currentUser
                if (user.groupo.id != groupo.id) {
                    //redirect controller: 'index', action: 'denied'
                    return false
                }
            }
        }

        return true;
    }

    def filters = {
        all(controller:'player', action:'*') {
            before = {
                println "Tracing player action ${actionUri} "
                if(!_checkGroupoCookie(actionUri, params, 'player', actionName)) {
                    // No groupoid => go to index
                    redirect controller: 'index', action: 'index'
                    return false;
                }
            }
        }
        all(controller:'session', action:'*') {
            before = {
                println "Tracing session action ${actionUri} "
                if(!_checkGroupoCookie(actionUri, params, 'session', actionName)) {
                    // No groupoid => go to index
                    redirect controller: 'index', action: 'index'
                    return false;
                }
            }
        }
        all(controller:'superUser', action:'*') {
            before = {
                println "Tracing superUser action ${actionUri} "
                if(!_checkGroupoCookie(actionUri, params, 'superUser', actionName)) {
                    // No groupoid => go to index
                    redirect controller: 'index', action: 'index'
                    return false;
                }
            }
        }
    }
}
