# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdf/kdf-4.6.5.ebuild,v 1.3 2011/08/15 19:47:05 maekke Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdeutils"
inherit kde4-meta

DESCRIPTION="KDE free disk space utility"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

src_unpack() {
	if use handbook; then
		KMEXTRA="doc/kcontrol/blockdevices"
	fi

	kde4-meta_src_unpack
}
