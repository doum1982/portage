# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/klu/klu-1.1.0.ebuild,v 1.3 2011/06/26 15:18:10 jlec Exp $

EAPI=2

inherit autotools eutils

MY_PN=KLU

DESCRIPTION="Sparse LU factorization for circuit simulation"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/klu/"
SRC_URI="http://www.cise.ufl.edu/research/sparse/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

DEPEND="
	sci-libs/amd
	sci-libs/btf
	sci-libs/colamd"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.0.1-autotools.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README.txt Doc/ChangeLog || die "dodoc failed"
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins Doc/*.pdf || die
	fi
}
