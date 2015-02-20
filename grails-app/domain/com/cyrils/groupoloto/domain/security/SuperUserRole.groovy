package com.cyrils.groupoloto.domain.security

import org.apache.commons.lang.builder.HashCodeBuilder

class SuperUserRole implements Serializable {

	private static final long serialVersionUID = 1

	SuperUser superUser
	Role role

	boolean equals(other) {
		if (!(other instanceof SuperUserRole)) {
			return false
		}

		other.superUser?.id == superUser?.id &&
		other.role?.id == role?.id
	}

	int hashCode() {
		def builder = new HashCodeBuilder()
		if (superUser) builder.append(superUser.id)
		if (role) builder.append(role.id)
		builder.toHashCode()
	}

	static SuperUserRole get(long superUserId, long roleId) {
		SuperUserRole.where {
			superUser == SuperUser.load(superUserId) &&
			role == Role.load(roleId)
		}.get()
	}

	static boolean exists(long superUserId, long roleId) {
		SuperUserRole.where {
			superUser == SuperUser.load(superUserId) &&
			role == Role.load(roleId)
		}.count() > 0
	}

	static SuperUserRole create(SuperUser superUser, Role role, boolean flush = false) {
		def instance = new SuperUserRole(superUser: superUser, role: role)
		instance.save(flush: flush, insert: true)
		instance
	}

	static boolean remove(SuperUser u, Role r, boolean flush = false) {
		if (u == null || r == null) return false

		int rowCount = SuperUserRole.where {
			superUser == SuperUser.load(u.id) &&
			role == Role.load(r.id)
		}.deleteAll()

		if (flush) { SuperUserRole.withSession { it.flush() } }

		rowCount > 0
	}

	static void removeAll(SuperUser u, boolean flush = false) {
		if (u == null) return

		SuperUserRole.where {
			superUser == SuperUser.load(u.id)
		}.deleteAll()

		if (flush) { SuperUserRole.withSession { it.flush() } }
	}

	static void removeAll(Role r, boolean flush = false) {
		if (r == null) return

		SuperUserRole.where {
			role == Role.load(r.id)
		}.deleteAll()

		if (flush) { SuperUserRole.withSession { it.flush() } }
	}

	static constraints = {
		role validator: { Role r, SuperUserRole ur ->
			if (ur.superUser == null) return
			boolean existing = false
			SuperUserRole.withNewSession {
				existing = SuperUserRole.exists(ur.superUser.id, r.id)
			}
			if (existing) {
				return 'userRole.exists'
			}
		}
	}

	static mapping = {
		id composite: ['role', 'superUser']
		version false
	}
}
