# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libpqxx/libpqxx-3.1-r2.ebuild,v 1.3 2011/05/09 23:13:59 hwoarang Exp $

EAPI="4"

inherit eutils

KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"

DESCRIPTION="C++ client API for PostgreSQL. The standard front-end for writing C++ programs that use PostgreSQL."
SRC_URI="http://pqxx.org/download/software/${PN}/${P}.tar.gz"
HOMEPAGE="http://pqxx.org/development/libpqxx/"
LICENSE="BSD"
SLOT="0"
IUSE="doc"

DEPEND="dev-db/postgresql-base"
RDEPEND="${DEPEND}"

PROPERTIES="interactive"

src_configure() {
	econf --enable-shared
}

src_install () {
	emake DESTDIR="${D}" install

	dodoc AUTHORS ChangeLog NEWS README*
	use doc && dohtml -r doc/html/*
}

src_test() {
	ewarn "The tests need a running PostgreSQL server version 8.4.x or older"
	ewarn "and an existing database."
	ewarn "Test requires PGDATABASE and PGUSER to be set at a minimum."
	ewarn "Optionally, set PGPORT and PGHOST."
	ewarn "Define them at the command line or in:"
	ewarn "    ${EROOT%/}/etc/libpqxx_test_env"
	ewarn "Make sure 'standard_conforming_strings' is set to off in postgresql.conf."

	if [[ -z $PGDATABASE || -z $PGUSER ]] ; then
		if [[ -f ${EROOT%/}/etc/libpqxx_test_env ]] ; then
			source "${EROOT%/}/etc/libpqxx_test_env"
			[[ -n $PGDATABASE ]] && export PGDATABASE
			[[ -n $PGHOST ]] && export PGHOST
			[[ -n $PGPORT ]] && export PGPORT
			[[ -n $PGUSER ]] && export PGUSER
		fi

		# In case the file wasn't written properly or doesn't exist
		if [[ -z $PGDATABASE || -z $PGUSER ]] ; then
			echo -n "Database (Default: $(whoami)): "
			read PGDATABASE
			[[ -n $PGDATABASE ]] && export PGDATABASE
			echo -n "Host (Default: Unix socket): "
			read PGHOST
			[[ -n $PGHOST ]] && export PGHOST
			echo -n "Port (Default: 5432): "
			read PGPORT
			[[ -n $PGPORT ]] && export PGPORT
			echo -n "User (Default: $(whoami)): "
			read PGUSER
			[[ -n $PGUSER ]] && export PGUSER
		fi
	fi

	local server_version
	server_version=$(psql -Aqwtc 'SELECT version();' 2> /dev/null)
	if [[ $? = 0 ]] ; then
		server_version=$(echo ${server_version} | cut -d " " -f 2 | cut -d "." -f -2 | tr -d .)
		if [[ $server_version < 90 ]] ; then
			cd "${S}/test"
			emake check
		else
			eerror "Server version must be 8.4.x or below."
			die "Server version isn't 8.4.x or below"
		fi
	else
		eerror "Is the server running?"
		eerror "Check that the role and database exist, and authentication method is set to"
		eerror "trust for:"
		eerror "    Role: ${PGUSER}"
		eerror "    Database: ${PGDATABASE}"
		die "Couldn't connect to server."
	fi
}
