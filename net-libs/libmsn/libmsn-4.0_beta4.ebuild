# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libmsn/libmsn-4.0_beta4.ebuild,v 1.5 2009/04/18 01:28:36 jer Exp $

inherit cmake-utils

MY_PV=${PV/_/-}
MY_P=${PN}-${MY_PV}

DESCRIPTION="Library for connecting to Microsoft's MSN Messenger service."
HOMEPAGE="http://sourceforge.net/projects/libmsn/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="dev-libs/openssl"

S="${WORKDIR}/${MY_P}"
