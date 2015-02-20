import com.cyrils.groupoloto.domain.security.Role
import com.cyrils.groupoloto.domain.security.SuperUser
import com.cyrils.groupoloto.domain.security.SuperUserRole

class BootStrap {

    def init = { servletContext ->

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

            admin.password = "admin"
            admin.save(flush: true)

            def roleAdmin = Role.findByAuthority("ROLE_ADMIN")
            if (!roleAdmin) {
                // Should not happen
                roleAdmin = new Role(authority: "ROLE_ADMIN").save(flush: true)
            }
            SuperUserRole.create(admin, roleAdmin, true)
        }

    }
    def destroy = {
    }
}
