# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/mc/mc-1.4.ebuild,v 1.4 2011/06/21 15:12:17 jlec Exp $

EAPI="2"

inherit autotools eutils fortran-2 multilib

DESCRIPTION="2D/3D AFEM code for nonlinear geometric PDE"
HOMEPAGE="http://fetk.org/codes/mc/index.html"
SRC_URI="http://www.fetk.org/codes/download/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="GPL-2"
IUSE="debug doc"

RDEPEND="
	virtual/fortran

	dev-libs/maloc
	media-libs/sg
	sci-libs/amd
	sci-libs/gamer
	sci-libs/punc
	sci-libs/superlu
	sci-libs/umfpack"
DEPEND="
	${RDEPEND}
	doc? (
		media-gfx/graphviz
		app-doc/doxygen )"

S="${WORKDIR}"/${PN}

src_prepare() {
	epatch \
		"${FILESDIR}"/${PV}-superlu.patch \
		"${FILESDIR}"/${PV}-overflow.patch \
		"${FILESDIR}"/${PV}-multilib.patch \
		"${FILESDIR}"/${PV}-doc.patch
	sed \
		-e 's:AMD_order:amd_order:g' \
		-e 's:UMFPACK_numeric:umfpack_di_numeric:g' \
		-e 's:buildg_:matvec_:g' \
		-i configure.ac || die
	eautoreconf
}

src_configure() {
	local fetk_include
	local fetk_lib
	local myconf

	use doc || myconf="${myconf} --with-doxygen= --with-dot="

	fetk_include="${EPREFIX}"/usr/include
	fetk_lib="${EPREFIX}"/usr/$(get_libdir)
	export FETK_INCLUDE="${fetk_include}"
	export FETK_LIBRARY="${fetk_lib}"
	export FETK_MPI_LIBRARY="${fetk_lib}"
	export FETK_VF2C_LIBRARY="${fetk_lib}"
	export FETK_BLAS_LIBRARY="${fetk_lib}"
	export FETK_LAPACK_LIBRARY="${fetk_lib}"
	export FETK_AMD_LIBRARY="${fetk_lib}"
	export FETK_UMFPACK_LIBRARY="${fetk_lib}"
	export FETK_SUPERLU_LIBRARY="${fetk_lib}"
	export FETK_ARPACK_LIBRARY="${fetk_lib}"
	export FETK_CGCODE_LIBRARY="${fetk_lib}"
	export FETK_PMG_LIBRARY="${fetk_lib}"

	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		$(use_enable debug vdebug) \
		--disable-triplet \
		--enable-shared \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die
}
