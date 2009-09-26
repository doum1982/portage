# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/openfoam/openfoam-1.6.ebuild,v 1.2 2009/09/25 09:28:54 flameeyes Exp $

EAPI="2"

inherit eutils versionator multilib toolchain-funcs

MY_PN="OpenFOAM"
MY_PV=$(get_version_component_range 1-2)
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Open Field Operation and Manipulation - CFD Simulation Toolbox"
HOMEPAGE="http://www.opencfd.co.uk/openfoam/"
SRC_URI="mirror://sourceforge/foam/${MY_P}.General.gtgz -> ${MY_P}.General.tgz
	mirror://gentoo/${MY_P}-compile.patch.bz2"

LICENSE="GPL-2"
SLOT="1.6"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND="!=sci-libs/openfoam-bin-${MY_PV}*
	!=sci-libs/openfoam-kernel-${MY_PV}*
	!=sci-libs/openfoam-meta-${MY_PV}*
	!=sci-libs/openfoam-solvers-${MY_PV}*
	!=sci-libs/openfoam-utilities-${MY_PV}*
	!=sci-libs/openfoam-wmake-${MY_PV}*
	sci-libs/parmetis
	sci-libs/parmgridgen
	sci-libs/scotch
	|| ( >sci-visualization/paraview-3.0 sci-visualization/opendx )
	virtual/mpi"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}
INSDIR="/usr/$(get_libdir)/${MY_PN}/${MY_P}"

pkg_setup() {
	# just to be sure the right profile is selected (gcc-config)
	if ! version_is_at_least 4.1 $(gcc-version) ; then
		die "${PN} requires >=sys-devel/gcc-4.1 to compile."
	fi

	elog
	elog "In order to use ${MY_PN} you should add the following line to ~/.bashrc :"
	elog
	elog "alias startOF$(delete_all_version_separators ${MY_PV})='source ${INSDIR}/etc/bashrc'"
	elog
	elog "And everytime you want to use OpenFOAM you have to execute startOF$(delete_all_version_separators ${MY_PV})"
	ewarn
	ewarn "FoamX is deprecated since ${MY_PN}-1.5! "
	ewarn
}

src_prepare() {
	epatch "${WORKDIR}"/${MY_P}-compile.patch
	epatch "${FILESDIR}"/${MY_P}_gcc4.4.patch
}

src_configure() {
	if has_version sys-cluster/mpich2 ; then
		export WM_MPLIB=MPICH
	elif has_version sys-cluster/openmpi ; then
		export WM_MPLIB=OPENMPI
	else
		die "You need one of the following mpi implementations: openmpi or mpich2"
	fi

	sed -i -e "s|WM_MPLIB:=OPENMPI|WM_MPLIB:="${WM_MPLIB}"|" etc/bashrc
	sed -i -e "s|setenv WM_MPLIB OPENMPI|setenv WM_MPLIB "${WM_MPLIB}"|" etc/cshrc
}

src_compile() {
	export FOAM_INST_DIR=${WORKDIR}
	source etc/bashrc

	find wmake -name dirToString | xargs rm -rf
	find wmake -name wmkdep | xargs rm -rf

	./Allwmake || die "could not build"
}

src_test() {
	cd bin
	./foamInstallationTest
}

src_install() {
	insinto ${INSDIR}
	doins -r etc

	use examples && doins -r tutorials

	insopts -m0755
	doins -r bin

	insinto ${INSDIR}/applications/bin
	doins -r applications/bin/*

	insinto ${INSDIR}/lib
	doins -r lib/*

	insinto ${INSDIR}/wmake
	doins -r wmake/*

	dodoc {doc/Guides-a4/*.pdf,README}

	if use doc ; then
		dohtml -r doc/Doxygen
	fi
}
