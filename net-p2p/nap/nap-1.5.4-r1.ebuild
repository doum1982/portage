# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/nap/nap-1.5.4-r1.ebuild,v 1.1 2008/11/27 21:43:37 armin76 Exp $

inherit toolchain-funcs

IUSE=""
DESCRIPTION="Console Napster/OpenNap client"
HOMEPAGE="http://www.mathstat.dal.ca/~selinger/nap/"
SRC_URI="http://www.mathstat.dal.ca/~selinger/nap/dist/${P}.tar.gz"

SLOT="0"
KEYWORDS="ppc x86"
LICENSE="as-is"

src_unpack() {
	unpack ${A}

	# Install the docs in the right dir
	sed -i -e "s~\$(prefix)/doc/nap~\$(prefix)/share/doc/${P}~g" \
		"${S}"/doc/Makefile.in
}

src_compile() {
	./configure --prefix="${D}"/usr --mandir="${D}"/usr/share/man || die "configure problem"
	emake CC="$(tc-getCC)" || die "compile problem"
}

src_install() {
	emake install || die "install problem"

	dodoc AUTHORS COPYRIGHT ChangeLog NEWS README
}
