# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-sgml-utils/docbook-sgml-utils-0.6.14-r1.ebuild,v 1.7 2011/03/25 10:26:30 xarthisius Exp $

EAPI=3

inherit eutils

MY_PN=${PN/-sgml/}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Shell scripts to manage DocBook documents"
HOMEPAGE="http://sources.redhat.com/docbook-tools/"
SRC_URI="ftp://sources.redhat.com/pub/docbook-tools/new-trials/SOURCES/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE="jadetex"

DEPEND=">=dev-lang/perl-5
	app-text/docbook-dsssl-stylesheets
	app-text/openjade
	dev-perl/SGMLSpm
	~app-text/docbook-xml-simple-dtd-4.1.2.4
	~app-text/docbook-xml-simple-dtd-1.0
	app-text/docbook-xml-dtd
	~app-text/docbook-sgml-dtd-3.0
	~app-text/docbook-sgml-dtd-3.1
	~app-text/docbook-sgml-dtd-4.0
	~app-text/docbook-sgml-dtd-4.1
	jadetex? ( app-text/jadetex )
	userland_GNU? ( sys-apps/which )
	|| (
		www-client/lynx
		www-client/links
		www-client/elinks
		virtual/w3m )"

# including both xml-simple-dtd 4.1.2.4 and 1.0, to ease
# transition to simple-dtd 1.0, <obz@gentoo.org>

src_prepare() {
	epatch "${FILESDIR}"/${MY_P}-elinks.patch
	epatch "${FILESDIR}"/${P}-grep-2.7.patch
}

src_install() {
	make DESTDIR="${D}" \
		htmldir="${EPREFIX}/usr/share/doc/${PF}/html" \
		install || die "Installation failed"

	if ! use jadetex ; then
		for i in dvi pdf ps ; do
			rm "${ED}"/usr/bin/docbook2$i || die
			rm "${ED}"/usr/share/sgml/docbook/utils-${PV}/backends/$i || die
			rm "${ED}"/usr/share/man/man1/docbook2$i.1 || die
		done
	fi
	dodoc AUTHORS ChangeLog NEWS README TODO || die
}
