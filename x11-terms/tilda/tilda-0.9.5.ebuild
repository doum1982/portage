# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/tilda/tilda-0.9.5.ebuild,v 1.6 2011/03/23 06:21:38 ssuominen Exp $

EAPI=2

DESCRIPTION="A drop down terminal, similar to the consoles found in first person shooters"
HOMEPAGE="http://tilda.sourceforge.net"
SRC_URI="mirror://sourceforge/tilda/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/vte:0
	>=dev-libs/glib-2.8.4
	dev-libs/confuse"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
}
