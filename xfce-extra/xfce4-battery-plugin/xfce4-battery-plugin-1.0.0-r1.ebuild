# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-battery-plugin/xfce4-battery-plugin-1.0.0-r1.ebuild,v 1.5 2011/05/19 20:40:06 ssuominen Exp $

EAPI=4
inherit xfconf

DESCRIPTION="A battery monitor panel plugin for the Xfce desktop environment"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-battery-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/1.0/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc x86"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=xfce-base/xfce4-panel-4.8
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/libxfcegui4-4.8"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	PATCHES=( "${FILESDIR}"/${P}-sysfs.patch )
	XFCONF=( $(xfconf_use_debug) )
	DOCS=( AUTHORS ChangeLog NEWS README )
}
