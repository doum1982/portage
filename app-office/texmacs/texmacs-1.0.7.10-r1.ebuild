# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/texmacs/texmacs-1.0.7.10-r1.ebuild,v 1.1 2011/03/17 20:21:24 grozin Exp $
EAPI=2
inherit autotools
MY_P=${P/tex/TeX}-src

DESCRIPTION="Wysiwyg text processor with high-quality maths"
HOMEPAGE="http://www.texmacs.org/"
SRC_URI="
	ftp://ftp.texmacs.org/pub/TeXmacs/targz/${MY_P}.tar.gz
	ftp://ftp.texmacs.org/pub/TeXmacs/targz/TeXmacs-600dpi-fonts.tar.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE="imlib jpeg netpbm -qt4 svg spell"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86 ~x86-interix ~amd64-linux ~x86-linux"

RDEPEND="dev-scheme/guile[deprecated]
	virtual/latex-base
	app-text/ghostscript-gpl
	media-libs/freetype
	x11-libs/libXext
	x11-apps/xmodmap
	qt4? ( x11-libs/qt-gui:4 )
	imlib? ( media-libs/imlib2 )
	jpeg? ( || ( media-gfx/imagemagick media-gfx/jpeg2ps ) )
	svg? ( || ( media-gfx/inkscape gnome-base/librsvg:2 ) )
	netpbm? ( media-libs/netpbm )
	spell? ( || ( >=app-text/ispell-3.2 >=app-text/aspell-0.5 ) )"
DEPEND="${RDEPEND}
	x11-proto/xproto"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if use qt4; then
		ewarn "Qt port is highly experimental"
		ewarn "If you want a stable TeXmacs, emerge with USE=-qt4"
	fi
}

src_prepare() {
	# don't strip
	epatch "${FILESDIR}"/${PN}-strip.patch

	# respect LDFLAGS, bug #338459
	epatch "${FILESDIR}"/${PN}-ldflags.patch

	# fix LD_LIBRARY_PATH in tm_mupad_help, bug #337532
	epatch "${FILESDIR}"/${PN}-mupad.patch

	eautoreconf
}

src_configure() {
	econf $(use_with imlib imlib2) \
		--enable-optimize="${CXXFLAGS}" \
		$(use_enable qt4 qt)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc TODO || die "dodoc failed"
	domenu "${FILESDIR}"/TeXmacs.desktop || die "domenu failed"

	# now install the fonts
	insinto /usr/share/texmf
	doins -r "${WORKDIR}/fonts" || die "installing fonts failed"
}
