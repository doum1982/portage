# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/nauty/nauty-2.4.2.ebuild,v 1.3 2010/12/18 12:10:38 hwoarang Exp $

EAPI="2"

inherit versionator

MY_PV=$(replace_version_separator 2 'r')
MY_PV=$(delete_version_separator 1 ${MY_PV})

DESCRIPTION="program for computing automorphism groups of graphs and digraphs."
HOMEPAGE="http://cs.anu.edu.au/~bdm/nauty/"
SRC_URI="http://cs.anu.edu.au/~bdm/${PN}/${PN}${MY_PV}.tar.gz"

LICENSE="nauty"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S="${WORKDIR}/${PN}${MY_PV}"

src_prepare () {
	sed -i "s/LDFLAGS=/LDFLAGS=${LDFLAGS}/" makefile.in || die
}

src_test () {
	make checks || die "tests failed"
}

src_install () {
	dobin addedgeg amtog biplabg catg complg copyg countg \
		deledgeg directg dreadnaut dretog genbg geng genrang \
		gentourng labelg listg multig newedgeg NRswitchg pickg \
		planarg shortg showg || die "install failed"
	dodoc README formats.txt
}
