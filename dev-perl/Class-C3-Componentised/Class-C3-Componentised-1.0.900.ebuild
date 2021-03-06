# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-C3-Componentised/Class-C3-Componentised-1.0.900.ebuild,v 1.1 2011/03/20 07:40:09 tove Exp $

EAPI=3

MODULE_AUTHOR=RIBASUSHI
MODULE_VERSION=1.0009
inherit perl-module

DESCRIPTION="Load mix-ins or components to your C3-based class."

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-solaris"
IUSE="test"

RDEPEND="dev-perl/MRO-Compat
	dev-perl/Class-Inspector
	>=dev-perl/Class-C3-0.20"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
		dev-perl/Test-Exception
	)"

SRC_TEST=do
