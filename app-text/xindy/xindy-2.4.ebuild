# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xindy/xindy-2.4.ebuild,v 1.3 2011/02/28 18:34:48 hwoarang Exp $

EAPI=3

inherit eutils autotools

DESCRIPTION="A Flexible Indexing System"
HOMEPAGE="http://www.xindy.org/"
SRC_URI="http://www.xindy.org/xindy-2.4.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~x86"
IUSE="doc"

RDEPEND="virtual/latex-base
	>=dev-lisp/clisp-2.44.1-r1
	|| ( dev-texlive/texlive-langcyrillic app-text/ptex )"
DEPEND="${RDEPEND}
	dev-lang/perl
	sys-devel/flex"

src_prepare() {
	epatch "${FILESDIR}"/${P}-configure.patch
	epatch "${FILESDIR}"/${P}-locale.patch
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable doc docs)
}

src_compile() {
	VARTEXFONTS="${T}/fonts" emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog.Gour NEWS README
}
