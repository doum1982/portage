# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/progressbar/progressbar-2.3.ebuild,v 1.3 2011/08/12 06:29:20 xarthisius Exp $

EAPI="3"
PYTHON_DEPEND="*"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Text progressbar library for python"
HOMEPAGE="http://code.google.com/p/python-progressbar/ http://pypi.python.org/pypi/progressbar"
SRC_URI="http://python-${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="|| ( LGPL-2.1 BSD )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="examples"

DEPEND="dev-python/setuptools"
RDEPEND=""

src_install() {
	distutils_src_install
	dodoc README.txt || die "dodoc failed"

	if use examples ; then
		exeinto /usr/share/doc/${PF}/examples
		doexe examples.py
	fi
}
