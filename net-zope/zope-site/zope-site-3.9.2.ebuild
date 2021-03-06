# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope-site/zope-site-3.9.2.ebuild,v 1.2 2010/12/05 19:05:03 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Local registries for zope component architecture"
HOMEPAGE="http://pypi.python.org/pypi/zope.site"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="net-zope/zope-annotation
	>=net-zope/zope-component-3.8.0
	net-zope/zope-container
	net-zope/zope-event
	net-zope/zope-filerepresentation
	net-zope/zope-interface
	net-zope/zope-lifecycleevent
	net-zope/zope-location
	net-zope/zope-security"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt"
PYTHON_MODNAME="${PN/-//}"
