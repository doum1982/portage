# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/uriparser/uriparser-0.7.5.ebuild,v 1.9 2011/06/14 18:52:46 sping Exp $

EAPI=2

inherit eutils autotools

DESCRIPTION="Uriparser is a strictly RFC 3986 compliant URI parsing library in C"
HOMEPAGE="http://uriparser.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="doc qt4 test"

RDEPEND=""
DEPEND="dev-util/pkgconfig
	doc? ( >=app-doc/doxygen-1.5.8
		qt4? ( x11-libs/qt-assistant ) )
	test? ( dev-util/cpptest )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-no-gifs.patch

	cd doc || die
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable doc) \
		$(use_enable test) \
		--disable-dependency-tracking \
		--docdir=/usr/share/doc/${PF}/
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog THANKS doc/*.txt || die

	if use doc && use qt4; then
		insinto /usr/share/doc/${PF}/
		doins doc/*.qch || die  # Using doins to avoiding dodoc's compression
	fi
}
