import com.cyrils.groupoloto.domain.Groupo
import com.cyrils.groupoloto.domain.security.Role
import com.cyrils.groupoloto.domain.security.SuperUser
import com.cyrils.groupoloto.domain.security.SuperUserRole

class BootStrap {

    static defaultGroupo = null;

    def init = { servletContext ->

        def defaultGroupo = Groupo.findByName("_DEFAULT_");
        if (!defaultGroupo) {
            // Create default groupo
            defaultGroupo = new Groupo();
            defaultGroupo.name = "_DEFAULT_";
            defaultGroupo.enable = true;
            defaultGroupo.save(flush: true)
        }

        def admin = SuperUser.findByUsername("admin")
        if (!admin) {

            // Création de l'user admin
            admin = new SuperUser()
            admin.accountExpired = false
            admin.accountLocked = false
            admin.email = "cyril.brouillard@gmail.com"
            admin.enabled = true
            admin.passwordExpired = false
            admin.username = "admin"
            admin.groupo = defaultGroupo

            admin.password = "admin"
            admin.save(flush: true)

            def roleAdmin = Role.findByAuthority("ROLE_ADMIN")
            def roleSuperAdmin = Role.findByAuthority("ROLE_SUPERADMIN")
            if (!roleAdmin) {
                // Should not happen
                roleAdmin = new Role(authority: "ROLE_ADMIN").save(flush: true)
            }
            if (!roleSuperAdmin){
                roleSuperAdmin = new Role(authority: "ROLE_SUPERADMIN").save(flush: true)
            }
            SuperUserRole.create(admin, roleAdmin, true)
            SuperUserRole.create(admin, roleSuperAdmin, true)
        }
    }

    def destroy = {
    }
}
