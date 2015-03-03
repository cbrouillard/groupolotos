import com.cyrils.groupoloto.domain.Groupo

class UrlMappings {

	static mappings = {

        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        /*
        "/$controller/$action?/$groupoid/$id?(.$format)?"{
            constraints {
                // apply constraints here
                def defaultGroupo = Groupo.findByName("_DEFAULT_");
                if (!groupoid) {
                    if (defaultGroupo.enable) {
                        groupoid = defaultGroupo.id
                    } else {
                        redirect controller: 'index', action: 'index'
                    }
                }
            }
        }
        */


        "/$id?"(controller: "index", action: 'index')
        "/"(controller: "index", action: 'index')
        "500"(view:'/error')
	}
}
