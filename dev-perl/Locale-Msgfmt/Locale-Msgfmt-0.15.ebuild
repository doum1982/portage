# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Locale-Msgfmt/Locale-Msgfmt-0.15.ebuild,v 1.1 2010/11/14 19:46:28 tove Exp $

EAPI=3

MODULE_AUTHOR=AZAWAWI
inherit perl-module

DESCRIPTION="Compile .po files to .mo files"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="
	test? ( dev-perl/Test-Pod )"

SRC_TEST=do
