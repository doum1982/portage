# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/icalendar/icalendar-2.2.ebuild,v 1.1 2011/08/31 15:52:23 nixphoeni Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2"

inherit eutils distutils

MY_PN="collective-${PN}"
S="${WORKDIR}/${MY_PN}-2354d4f"

DESCRIPTION="Package used for parsing and generating iCalendar files (RFC 2445)."
HOMEPAGE="http://github.com/collective/icalendar"
SRC_URI="http://github.com/collective/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
RESTRICT="test"

RDEPEND=""
DEPEND="dev-python/setuptools
	doc? ( dev-python/sphinx )"
RESTRICT_PYTHON_ABIS="3.*"

DOCS="CHANGES.txt CREDITS.txt HISTORY.txt TODO.txt"

src_compile() {
	distutils_src_compile

	if use doc; then
		cd docs
		emake text || die "building documentation"
		DOCS="${DOCS} docs/_build/text/*.txt"
	fi
}
