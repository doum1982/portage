# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-meta/kdeartwork-meta-3.5.10.ebuild,v 1.6 2009/07/08 13:31:48 alexxy Exp $

EAPI="1"
inherit kde-functions
DESCRIPTION="kdeartwork - merge this to pull in all kdeartwork-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="~alpha amd64 hppa ~ia64 ~mips ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="
>=kde-base/kdeartwork-emoticons-${PV}:${SLOT}
>=kde-base/kdeartwork-iconthemes-${PV}:${SLOT}
>=kde-base/kdeartwork-icewm-themes-${PV}:${SLOT}
>=kde-base/kdeartwork-kscreensaver-${PV}:${SLOT}
>=kde-base/kdeartwork-kwin-styles-${PV}:${SLOT}
>=kde-base/kdeartwork-kworldclock-${PV}:${SLOT}
>=kde-base/kdeartwork-sounds-${PV}:${SLOT}
>=kde-base/kdeartwork-styles-${PV}:${SLOT}
>=kde-base/kdeartwork-wallpapers-${PV}:${SLOT}
"
