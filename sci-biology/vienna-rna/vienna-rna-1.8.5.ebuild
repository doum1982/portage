# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/vienna-rna/vienna-rna-1.8.5.ebuild,v 1.3 2011/05/03 11:10:40 jlec Exp $

EAPI="3"

PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils toolchain-funcs multilib autotools perl-module

DESCRIPTION="RNA secondary structure prediction and comparison"
HOMEPAGE="http://www.tbi.univie.ac.at/~ivo/RNA/"
SRC_URI="http://www.tbi.univie.ac.at/~ivo/RNA/ViennaRNA-${PV}.tar.gz"

LICENSE="vienna-rna"
SLOT="0"
IUSE="python"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="
	dev-lang/perl
	media-libs/gd"
RDEPEND="${DEPEND}"

S="${WORKDIR}/ViennaRNA-${PV}"

PATCHES=(
	"${FILESDIR}"/${PN}-1.6.5-c-fixes.patch
	"${FILESDIR}"/${PN}-1.7.2-LDFLAGS.patch
	"${FILESDIR}"/${PN}-1.8.3-gcc4.3.patch
	"${FILESDIR}"/${PN}-1.8.3-disable-gd.patch
	"${FILESDIR}"/${PN}-1.8.4-jobserver-fix.patch
	"${FILESDIR}"/${PN}-1.8.4-bindir.patch
	"${FILESDIR}"/${PN}-1.8.4-overflows.patch
	"${FILESDIR}"/${PN}-1.8.4-implicits.patch
)

src_prepare() {
	base_src_prepare
	sed -i 's/ getline/ v_getline/' Readseq/ureadseq.c || die
	sed -i 's/@PerlCmd@ Makefile.PL/& INSTALLDIRS=vendor/' Perl/Makefile.am || die

	eautoreconf
	cd RNAforester && eautoreconf
	use python && cp "${FILESDIR}"/${P}-setup.py "${S}"/setup.py
}

src_configure() {
	econf --with-cluster
	sed -e "s:LIBDIR = /usr/lib:LIBDIR = ${D}/usr/$(get_libdir):" \
		-e "s:INCDIR = /usr/include:INCDIR = ${D}/usr/include:" \
		-i RNAforester/g2-0.70/Makefile \
			|| die "Failed patching RNAForester build system."
	sed -e "s:CC=cc:CC=$(tc-getCC):" -e "s:CFLAGS=:CFLAGS=${CFLAGS}:" \
		-i Readseq/Makefile || die "Failed patching readseq Makefile."
}

src_compile() {
	emake clean || die
	emake || die
	emake -C Readseq || die "Failed to compile readseq."
	# TODO: Add (optional?) support for the NCBI toolkit.
	if use python; then
		pushd Perl > /dev/null
			mv RNA_wrap.c{,-perl}
			swig -python RNA.i
		popd > /dev/null
		distutils_src_compile
		mv Perl/RNA_wrap.c{-perl,}
	fi
}

src_test() {
	cd "${S}"/Perl && emake check || die "Perl tests failed"
	cd "${S}"/Readseq && emake test || die "Readseq tests failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS || die
	newbin Readseq/readseq readseq-vienna || die
	dodoc Readseq/Readseq.help || die
	newdoc Readseq/Readme README.readseq || die
	newdoc Readseq/Formats Formats.readseq || die

	# remove perlocal.pod to avoid file collisions (see #240358)
	fixlocalpod || die "Failed to remove perlocal.pod"
	use python && distutils_src_install
}
