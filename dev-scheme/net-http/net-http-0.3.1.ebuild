# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/net-http/net-http-0.3.1.ebuild,v 1.5 2010/06/28 21:40:27 angelos Exp $

DESCRIPTION="Library for doing HTTP client-side programming in Guile"
HOMEPAGE="http://evan.prodromou.name/software/net-http/"
SRC_URI="http://evan.prodromou.name/software/net-http/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""
RDEPEND="dev-scheme/guile"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${PN}"

src_compile() {
	# Scheme doesn't compile
	true
}

src_install() {
	local GUILE_DIR="/usr/share/guile/site"
	dodir ${GUILE_DIR}
	cp -R ${S}/net ${D}${GUILE_DIR}
	dodoc ${S}/README
}
