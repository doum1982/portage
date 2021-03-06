# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Audio-Scan/Audio-Scan-0.870.0.ebuild,v 1.1 2011/03/22 06:56:10 tove Exp $

EAPI=3

MODULE_AUTHOR=AGRUNDMA
MODULE_VERSION=0.87
inherit perl-module

DESCRIPTION="Fast C metadata and tag reader for all common audio file formats"

LICENSE="|| ( GPL-2 GPL-3 )" # GPL-2+
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Warn
	)"
#		dev-perl/Test-Pod
#		dev-perl/Test-Pod-Coverage"

SRC_TEST=do
