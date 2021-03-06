# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/see/see-0.6.ebuild,v 1.1 2010/10/20 20:35:02 dev-zero Exp $

EAPI=3

inherit autotools eutils

DESCRIPTION="Clever, lightweight GUI text file and manual page viewer for X windows."
HOMEPAGE="http://code.google.com/p/seetxt/"
SRC_URI="http://seetxt.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}/${PV}-respect_destdir.patch"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS
}
