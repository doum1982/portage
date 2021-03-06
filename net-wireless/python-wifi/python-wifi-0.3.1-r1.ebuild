# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/python-wifi/python-wifi-0.3.1-r1.ebuild,v 1.2 2011/03/09 16:12:03 jlec Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Provides r/w access to a wireless network card's capabilities using the Linux Wireless Extensions"
HOMEPAGE="http://pypi.python.org/pypi/python-wifi"
SRC_URI="
	mirror://pypi/packages/source/p/${PN}/${P}.tar.gz
	mirror://berlios/${PN/-}/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="LGPL-2.1 examples? ( GPL-2 )"
IUSE="examples"

RDEPEND=""
DEPEND="dev-python/setuptools"

DOCS="docs/AUTHORS docs/BUGS docs/DEVEL.txt docs/TODO"
PYTHON_MODNAME="pythonwifi"

src_install() {
	distutils_src_install
	if use examples; then
		insinto /usr/share/${P}/
		doins -r examples || die "no examples"
	fi
}
