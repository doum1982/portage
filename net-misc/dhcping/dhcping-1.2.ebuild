# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcping/dhcping-1.2.ebuild,v 1.6 2010/10/28 10:49:53 ssuominen Exp $

DESCRIPTION="Utility for sending a dhcp request to a dhcp server to see if it is responding."
HOMEPAGE="http://www.mavetju.org/unix/general.php"
SRC_URI="http://www.mavetju.org/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die
}
