# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kglobalaccel/kglobalaccel-4.6.3.ebuild,v 1.4 2011/06/26 01:54:41 ranger Exp $

EAPI=4

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="KDE's Global Shortcut Daemon"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

# Module renamed upstream
add_blocker kdedglobalaccel

src_configure() {
	mycmakeargs=(
		-DKDEBASE_KGLOBALACCEL_REMOVE_OBSOLETE_KDED_DESKTOP_FILE=NOTFOUND
		-DKDEBASE_KGLOBALACCEL_REMOVE_OBSOLETE_KDED_PLUGIN=NOTFOUND
	)

	kde4-meta_src_configure
}
