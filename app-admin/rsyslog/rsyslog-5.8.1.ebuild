# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/rsyslog/rsyslog-5.8.1.ebuild,v 1.1 2011/05/23 08:01:54 ultrabug Exp $

EAPI=4

inherit autotools-utils systemd

DESCRIPTION="An enhanced multi-threaded syslogd with database support and more."
HOMEPAGE="http://www.rsyslog.com/"
SRC_URI="http://www.rsyslog.com/files/download/${PN}/${P}.tar.gz"

LICENSE="GPL-3 LGPL-3"
KEYWORDS="~amd64 ~arm ~hppa ~sparc ~x86"
SLOT="0"
IUSE="dbi debug doc extras gnutls kerberos mysql oracle postgres relp snmp static-libs zlib"

DEPEND="dbi? ( dev-db/libdbi )
	extras? ( net-libs/libnet )
	gnutls? ( net-libs/gnutls )
	kerberos? ( virtual/krb5 )
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-base )
	oracle? ( dev-db/oracle-instantclient-basic )
	relp? ( >=dev-libs/librelp-0.1.3 )
	snmp? ( net-analyzer/net-snmp )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

BRANCH="5-stable"

# need access to certain device nodes
RESTRICT="test"

# Maitainer note : open a bug to upstream
# showing that building in a separate dir fails
AUTOTOOLS_IN_SOURCE_BUILD=1

DOCS=(AUTHORS ChangeLog doc/rsyslog-example.conf)

src_configure() {
	# Maintainer notes:
	# * rfc3195 needs a library and development of that library
	#   is suspended, so we disable it
	# * About the java GUI:
	#   The maintainer says there is no real installation support
	#   for the java GUI, so we disable it for now.
	local myeconfargs=(
		--disable-gui
		--disable-rfc3195
		--enable-largefile
		--enable-unlimited-select
		--enable-imdiag
		--enable-imfile
		--enable-impstats
		--enable-imtemplate
		--enable-imptcp
		--enable-mail
		--enable-omprog
		--enable-omstdout
		--enable-omtemplate
		--enable-omdbalerting
		--enable-omuxsock
		--enable-pmlastmsg
		--enable-pmrfc3164sd
		--enable-pmcisconames
		--enable-pmaixforwardedfrom
		--enable-pmsnare
		$(use_enable extras omudpspoof)
		$(use_enable zlib)
		$(use_enable mysql)
		$(use_enable dbi libdbi)
		$(use_enable postgres pgsql)
		$(use_enable oracle oracle)
		$(use_enable gnutls)
		$(use_enable kerberos gssapi-krb5)
		$(use_enable relp)
		$(use_enable snmp)
		$(use_enable snmp mmsnmptrapd)
		$(use_enable debug)
		$(use_enable debug rtinst)
		$(use_enable debug diagtools)
		$(use_enable debug memcheck)
		$(use_enable debug valgrind)
	)

	systemd_to_myeconfargs
	autotools-utils_src_configure
}

src_install() {
	use doc && HTML_DOCS=(doc/)
	autotools-utils_src_install

	insinto /etc
	newins "${FILESDIR}/${BRANCH}/${PN}-gentoo.conf" ${PN}.conf
	newconfd "${FILESDIR}/${BRANCH}/${PN}.confd" ${PN}
	newinitd "${FILESDIR}/${BRANCH}/${PN}.initd" ${PN}
	keepdir /var/spool/${PN}
	keepdir /etc/ssl/${PN}
	keepdir /etc/${PN}.d

	if use mysql; then
		insinto /usr/share/doc/${PF}/scripts/mysql
		doins plugins/ommysql/{createDB.sql,contrib/delete_mysql}
	fi

	if use postgres; then
		insinto /usr/share/doc/${PF}/scripts/pgsql
		doins plugins/ompgsql/createDB.sql
	fi

	insinto /etc/logrotate.d/
	newins "${FILESDIR}/${BRANCH}/${PN}.logrotate" ${PN}
}

pkg_postinst() {
	if use mysql || use postgres; then
		echo
		elog "Sample SQL scripts for MySQL & PostgreSQL have been installed to:"
		elog "  /usr/share/doc/${PF}/scripts"
	fi

	if use gnutls; then
		echo
		elog "To create a default CA and certificates for your server and clients, run:"
		elog "  emerge --config =${PF}"
		elog "on your logging server. You can run it several times,"
		elog "once for each logging client. The client certificates will be signed"
		elog "using the CA certificate generated during the first run."
	fi
}

pkg_config() {
	if ! use gnutls ; then
		einfo "There is nothing to configure for rsyslog unless you"
		einfo "used USE=gnutls to build it."
		return 0
	fi

	# Make sure the certificates directory exists
	CERTDIR="${ROOT}/etc/ssl/${PN}"
	if [ ! -d "${CERTDIR}" ]; then
		mkdir "${CERTDIR}" || die
	fi
	einfo "Your certificates will be stored in ${CERTDIR}"

	# Create a default CA if needed
	if [ ! -f "${CERTDIR}/${PN}_ca.cert.pem" ]; then
		einfo "No CA key and certificate found in ${CERTDIR}, creating them for you..."
		certtool --generate-privkey \
			--outfile "${CERTDIR}/${PN}_ca.privkey.pem" &>/dev/null
		chmod 400 "${CERTDIR}/${PN}_ca.privkey.pem"

		cat > "${T}/${PF}.$$" <<_EOF
		cn = Portage automated CA
		ca
		cert_signing_key
		expiration_days = 3650
_EOF

		certtool --generate-self-signed \
			--load-privkey "${CERTDIR}/${PN}_ca.privkey.pem" \
			--outfile "${CERTDIR}/${PN}_ca.cert.pem" \
			--template "${T}/${PF}.$$" &>/dev/null
		chmod 400 "${CERTDIR}/${PN}_ca.privkey.pem"

		# Create the server certificate
		echo
		einfon "Please type the Common Name of the SERVER you wish to create a certificate for: "
		read -r CN

		einfo "Creating private key and certificate for server ${CN}..."
		certtool --generate-privkey \
			--outfile "${CERTDIR}/${PN}_${CN}.key.pem" &>/dev/null
		chmod 400 "${CERTDIR}/${PN}_${CN}.key.pem"

		cat > "${T}/${PF}.$$" <<_EOF
		cn = ${CN}
		tls_www_server
		dns_name = ${CN}
		expiration_days = 3650
_EOF

		certtool --generate-certificate \
			--outfile "${CERTDIR}/${PN}_${CN}.cert.pem" \
			--load-privkey "${CERTDIR}/${PN}_${CN}.key.pem" \
			--load-ca-certificate "${CERTDIR}/${PN}_ca.cert.pem" \
			--load-ca-privkey "${CERTDIR}/${PN}_ca.privkey.pem" \
			--template "${T}/${PF}.$$" &>/dev/null
		chmod 400 "${CERTDIR}/${PN}_${CN}.cert.pem"

	else
		einfo "Found existing ${CERTDIR}/${PN}_ca.cert.pem, skipping CA and SERVER creation."
	fi

	# Create a client certificate
	echo
	einfon "Please type the Common Name of the CLIENT you wish to create a certificate for: "
	read -r CN

	einfo "Creating private key and certificate for client ${CN}..."
	certtool --generate-privkey \
		--outfile "${CERTDIR}/${PN}_${CN}.key.pem" &>/dev/null
	chmod 400 "${CERTDIR}/${PN}_${CN}.key.pem"

	cat > "${T}/${PF}.$$" <<_EOF
	cn = ${CN}
	tls_www_client
	dns_name = ${CN}
	expiration_days = 3650
_EOF

	certtool --generate-certificate \
		--outfile "${CERTDIR}/${PN}_${CN}.cert.pem" \
		--load-privkey "${CERTDIR}/${PN}_${CN}.key.pem" \
		--load-ca-certificate "${CERTDIR}/${PN}_ca.cert.pem" \
		--load-ca-privkey "${CERTDIR}/${PN}_ca.privkey.pem" \
		--template "${T}/${PF}.$$" &>/dev/null
	chmod 400 "${CERTDIR}/${PN}_${CN}.cert.pem"

	rm -f "${T}/${PF}.$$"

	echo
	einfo "Here is the documentation on how to encrypt your log traffic:"
	einfo " http://www.rsyslog.com/doc/rsyslog_tls.html"
}
