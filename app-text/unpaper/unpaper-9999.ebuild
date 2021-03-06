# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/unpaper/unpaper-9999.ebuild,v 1.1 2011/08/15 03:24:54 flameeyes Exp $

EAPI=4
EGIT_REPO_URI="git://github.com/Flameeyes/unpaper.git"

inherit git-2 autotools

DESCRIPTION="Post-processor for scanned and photocopied book pages"
HOMEPAGE="http://unpaper.berlios.de/
	https://github.com/flameeyes/unpaper"

LICENSE="GPL-2"

KEYWORDS=""
SLOT="0"
IUSE="test"

DEPEND="test? ( media-libs/netpbm[png] )"
RDEPEND=""

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		--docdir=/usr/share/doc/${PF} \
		--htmldir=/usr/share/doc/${PF}/html
}

src_test() {
	emake check
}

src_install() {
	emake DESTDIR="${D}" install
}
