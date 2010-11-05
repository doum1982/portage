# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-C3/Class-C3-0.23.ebuild,v 1.4 2010/11/05 13:08:15 hwoarang Exp $

EAPI=2

MODULE_AUTHOR=FLORA
inherit perl-module

DESCRIPTION="A pragma to use the C3 method resolution order algortihm"

SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~sparc x86 ~ppc-macos ~x86-solaris"
IUSE="test"

RDEPEND="
	|| ( >=dev-lang/perl-5.10
		>=dev-perl/Class-C3-XS-0.07 )"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
