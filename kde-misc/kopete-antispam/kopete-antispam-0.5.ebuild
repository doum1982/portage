# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kopete-antispam/kopete-antispam-0.5.ebuild,v 1.2 2011/01/31 05:39:38 tampakrap Exp $

EAPI=3

inherit kde4-base

MY_PN=${PN/-/}
MY_P="${PN}-kde4-${PV}"

DESCRIPTION="Antispam filter for Kopete instant messenger."
HOMEPAGE="http://kopeteantispam.sourceforge.net"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	$(add_kdebase_dep kopete)
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

pkg_postinst() {
	elog "You can now enable and set up the Antispam plugin in Kopete."
	elog "It can be reached in the Kopete Plugin dialog."
}
