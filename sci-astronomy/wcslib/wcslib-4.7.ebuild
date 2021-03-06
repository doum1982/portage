# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/wcslib/wcslib-4.7.ebuild,v 1.3 2011/06/21 16:08:54 jlec Exp $

EAPI=3
inherit eutils fortran-2 virtualx

DESCRIPTION="Astronomical World Coordinate System transformations library"
HOMEPAGE="http://www.atnf.csiro.au/people/mcalabre/WCS/"
SRC_URI="ftp://ftp.atnf.csiro.au/pub/software/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="LGPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="doc fortran fits pgplot test"

RDEPEND="
	fortran? ( virtual/fortran )

	fits? ( sci-libs/cfitsio )
	pgplot? ( sci-libs/pgplot )"
DEPEND="${RDEPEND}
	test? (
		media-fonts/font-misc-misc
		media-fonts/font-cursor-misc )"

pkg_setup() {
	use fortran && fortran-2_pkg_setup
}

src_configure() {
	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		$(use_enable fortran) \
		$(use_with fits cfitsio) \
		$(use_with pgplot)
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_test() {
	Xemake check || die "emake test failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r *.pdf html || die
	fi
}
