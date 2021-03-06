# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wimax-tools/wimax-tools-1.4.5.ebuild,v 1.1 2011/04/20 17:13:24 alexxy Exp $

EAPI="3"

inherit linux-info base

DESCRIPTION="Tools to use Intel's WiMax cards"
HOMEPAGE="http://www.linuxwimax.org"
SRC_URI="http://linuxwimax.org/Download?action=AttachFile&do=get&target=${P}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-kernel/linux-headers-2.6.34
		>=dev-libs/libnl-1.0"
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}
