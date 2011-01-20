# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/audacious-dumb/audacious-dumb-0.65.ebuild,v 1.1 2011/01/20 16:06:16 joker Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="Audacious Plug-in for accurate, high-quality IT/XM/S3M/MOD playback"
HOMEPAGE="http://www.netswarm.net/"
SRC_URI="http://www.netswarm.net/misc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-sound/audacious-2.4.3
	>=media-libs/dumb-0.9.3"

DEPEND="dev-util/pkgconfig
	${RDEPEND}"

src_compile() {
	tc-export CC
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog README README-dumb-bmp README-dumb-xmms
}
