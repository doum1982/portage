# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kinfocenter/kinfocenter-4.6.5.ebuild,v 1.3 2011/08/15 21:50:41 maekke Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdebase-workspace"
OPENGL_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="The KDE Info Center"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug ieee1394"

DEPEND="
	$(add_kdebase_dep solid)
	sys-apps/pciutils
	ieee1394? ( sys-libs/libraw1394 )
	opengl? (
		virtual/glu
		virtual/opengl
	)
"
RDEPEND="${DEPEND}
	sys-apps/usbutils
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with ieee1394 RAW1394)
		$(cmake-utils_use_with opengl OpenGL)
	)

	kde4-meta_src_configure
}
