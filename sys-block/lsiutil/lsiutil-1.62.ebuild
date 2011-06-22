# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/lsiutil/lsiutil-1.62.ebuild,v 1.1 2011/06/21 20:07:45 idl0r Exp $

EAPI="3"

DESCRIPTION="LSI Logic Fusion MPT Command Line Interface management tool"
HOMEPAGE="http://www.lsi.com/"
SRC_URI="http://www.lsi.com/downloads/Public/Obsolete/Obsolete%20Common%20Files/LSIUtil_${PV}.zip"

LICENSE="LSI"
SLOT="0"
# This package can never enter stable, it can't be mirrored and upstream
# can remove the distfiles from their mirror anytime.
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

RESTRICT="mirror bindist"

RDEPEND=""
DEPEND="app-arch/unzip"

src_install() {
	if use x86; then
		dosbin Linux/lsiutil || die
	elif use amd64; then
		newsbin Linux/lsiutil.x86_64 lsiutil || die
	elif use ia64; then
		newsbin Linux/lsiutil.ia64 lsiutil || die
	fi

	dodoc changes.txt
}
