# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/agrep/agrep-2.04.ebuild,v 1.22 2011/02/06 05:32:25 leio Exp $

inherit toolchain-funcs

DESCRIPTION="agrep is a tool for the fast searching of text allowing for errors in the search pattern."
HOMEPAGE="ftp://ftp.cs.arizona.edu/agrep/README"
SRC_URI="ftp://ftp.cs.arizona.edu/agrep/${P}.tar.Z"

LICENSE="AGREP"
SLOT="0"
KEYWORDS="amd64 ~mips ppc ppc64 sparc x86 ~ppc-macos ~sparc-solaris"
IUSE=""

DEPEND=""
RDEPEND="
	!dev-libs/tre
	!app-misc/glimpse"

src_compile() {
	# Remove first occurace of CFLAGS so we grab the user CFLAGS
	sed -i -e 's/^CFLAGS.*//' Makefile || die
	tc-export CC
	emake || die
}

src_install() {
	dobin agrep || die
	doman agrep.1 || die
	dodoc README agrep.algorithms agrep.chronicle COPYRIGHT \
		contribution.list || die
}
