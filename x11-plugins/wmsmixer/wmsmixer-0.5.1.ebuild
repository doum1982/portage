# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmsmixer/wmsmixer-0.5.1.ebuild,v 1.13 2011/05/26 12:46:13 s4t4n Exp $

inherit eutils
IUSE=""
DESCRIPTION="fork of wmmixer adding scrollwheel support and other features"
HOMEPAGE="http://www.dockapps.org/file.php/id/63"
SRC_URI="http://www.dockapps.org/download.php/id/268/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 sparc x86"

RDEPEND="x11-libs/libXpm
	x11-libs/libXext
	x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto"

src_compile() {
	g++ ${CFLAGS} -I/usr/X11R6/include -c -o wmsmixer.o wmsmixer.cc
	rm -f wmsmixer
	g++ ${LDFLAGS} -o wmsmixer ${CFLAGS} -L/usr/X11R6/lib wmsmixer.o -lXpm -lXext -lX11
}

src_install() {
	insinto /usr/bin
	insopts -m0655
	doins wmsmixer
	dodoc README README.wmmixer
}
