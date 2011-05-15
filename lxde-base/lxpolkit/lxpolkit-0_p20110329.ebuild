# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxpolkit/lxpolkit-0_p20110329.ebuild,v 1.4 2011/05/15 11:18:14 phajdan.jr Exp $

EAPI=4
inherit autotools

DESCRIPTION="A simple PolicyKit authentication agent"
HOMEPAGE="http://lxde.git.sourceforge.net/git/gitweb.cgi?p=lxde/lxpolkit;a=summary"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=sys-auth/polkit-0.99-r1
	>=x11-libs/gtk+-2.12:2
	!gnome-extra/polkit-gnome"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40.0
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	sed -i -e 's:GNOME;::' data/lxpolkit.desktop.in.in || die

	local x
	for x in lxpolkit.desktop.in ui/lxpolkit.ui; do #352716
		echo data/${x} >> po/POTFILES.skip
	done

	intltoolize --force --copy --automake || die
	eautoreconf
}
