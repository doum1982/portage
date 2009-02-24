# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/gtk-gamess/gtk-gamess-2.00.ebuild,v 1.6 2009/02/23 16:28:52 josejx Exp $

DESCRIPTION="GTK-GAMESS is a graphical frontend for GAMESS, a General Atomic and Molecular Electronic Structure System"
HOMEPAGE="http://sourceforge.net/projects/gtk-gamess/"

SRC_URI="mirror://sourceforge/gtk-gamess/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~ppc ~x86"

IUSE=""

RDEPEND=">=gnome-base/libglade-2.4
	>=x11-libs/gtk+-2.6
	dev-libs/libxml2
	sci-chemistry/gamess"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {

	make DESTDIR="${D}" install || die "install failed"
	dodoc README
}
