# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/htmlinc/htmlinc-1.0_beta1-r2.ebuild,v 1.1 2010/09/17 04:08:48 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="HTML Include System by Ulli Meybohm"
HOMEPAGE="http://www.meybohm.de/"
SRC_URI="http://meybohm.de/files/${PN}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86 ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

S=${WORKDIR}/htmlinc

src_prepare() {
	epatch "${FILESDIR}"/htmlinc-gcc3-gentoo.patch
	sed -i Makefile \
		-e 's| -o | $(LDFLAGS)&|g' \
		|| die "sed Makefile"
}

src_compile() {
	# This is C++ not C source
	emake CC=$(tc-getCXX) \
		CFLAGS="${CXXFLAGS} -Wall" \
		LDFLAGS="${LDFLAGS}" \
		|| die
}

src_install() {
	dobin htmlinc
	dodoc README
}
