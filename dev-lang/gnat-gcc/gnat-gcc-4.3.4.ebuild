# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gnat-gcc/gnat-gcc-4.3.4.ebuild,v 1.3 2011/01/04 20:18:44 george Exp $

# Need to let configure know where to find stddef.h
#EXTRA_CONFGCC="${WORKDIR}/usr/lib/include/"

inherit gnatbuild

DESCRIPTION="GNAT Ada Compiler - gcc version"
HOMEPAGE="http://gcc.gnu.org/"
LICENSE="GMGPL"

IUSE=""

# using new bootstrap
BOOT_SLOT="4.3"

# SLOT is set in gnatbuild.eclass, depends only on PV (basically SLOT=GCCBRANCH)
# so the URI's are static.
SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/gcc-${PV}/gcc-core-${PV}.tar.bz2
	ftp://gcc.gnu.org/pub/gcc/releases/gcc-${PV}/gcc-ada-${PV}.tar.bz2
	amd64? ( mirror://gentoo/gnatboot-${BOOT_SLOT}-amd64.tar.bz2 )
	sparc? ( mirror://gentoo/gnatboot-${BOOT_SLOT}-sparc.tar.bz2 )
	x86?   ( http://dev.gentoo.org/~george/src/gnatboot-${BOOT_SLOT}-i686.tar.bz2 )"
#	ppc?   ( mirror://gentoo/gnatboot-${BOOT_SLOT}-ppc.tar.bz2 )

KEYWORDS="~amd64 ~x86 ~sparc"

# starting with 4.3.0 gnat needs these libs
DEPEND=">=dev-libs/mpfr-2.3.1
	>=dev-libs/gmp-4.2.2"
RDEPEND="${DEPEND}"

#QA_EXECSTACK="${BINPATH:1}/gnatls ${BINPATH:1}/gnatbind ${BINPATH:1}/gnatmake
#	${LIBEXECPATH:1}/gnat1 ${LIBPATH:1}/adalib/libgnat-${SLOT}.so"

src_unpack() {
	gnatbuild_src_unpack

	#fixup some hardwired flags
	cd "${S}"/gcc/ada

	# universal gcc -> gnatgcc substitution occasionally produces lines too long
	# and then build halts on the style check.
	#
	# The sed in makegpr.adb is actually not for the line length but rather to
	# "undo" the fixing, Last3 is matching just that - the last three characters
	# of the compiler name.
	sed -i -e 's:(Last3 = "gnatgcc"):(Last3 = "gcc"):' makegpr.adb &&
	sed -i -e 's:and Nam is "gnatgcc":and Nam is "gcc":' osint.ads ||
		die	"reversing [gnat]gcc substitution in comments failed"

	# looks like wrapper has problems with all the quotation
	sed -i -e "/-DREVISION/d" -e "/-DDEVPHASE/d" \
		-e "s: -DDATESTAMP=\$(DATESTAMP_s)::" "${S}"/gcc/Makefile.in
	sed -i -e "s: DATESTAMP DEVPHASE REVISION::" \
		-e "s:PKGVERSION:\"\":" "${S}"/gcc/version.c
}

src_compile() {
	# looks like gnatlib_and_tools and gnatlib_shared have become part of
	# bootstrap
	gnatbuild_src_compile configure make-tools bootstrap
}
