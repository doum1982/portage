# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libbluray-xine/libbluray-xine-9999.ebuild,v 1.2 2011/08/22 09:11:35 radhermit Exp $

EAPI=4

inherit git-2 toolchain-funcs

EGIT_REPO_URI="git://git.videolan.org/libbluray.git"

MY_P="libbluray-${PV}"
DESCRIPTION="Xine plugin for blu-ray playback libraries"
HOMEPAGE="http://www.videolan.org/developers/libbluray.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	~media-libs/libbluray-${PV}
	media-libs/xine-lib
"
RDEPEND="
	${COMMON_DEPEND}
"
DEPEND="
	${COMMON_DEPEND}
	dev-util/pkgconfig
"

DOCS=( HOWTO )

EGIT_SOURCEDIR="${WORKDIR}/${MY_P}"
S="${WORKDIR}/${MY_P}/player_wrappers/xine"

src_prepare() {
	sed -i -e "s:-O2 ::" Makefile || die
	tc-export CC
}
