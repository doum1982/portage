# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Address/Email-Address-1.88.9.ebuild,v 1.7 2010/01/09 19:51:44 grobian Exp $

inherit versionator
MODULE_AUTHOR=RJBS
MY_P=${PN}-$(delete_version_separator 2)
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Email::Address - RFC 2822 Address Parsing and Creation"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Simple
		>=dev-perl/Test-Pod-1.14
		>=dev-perl/Test-Pod-Coverage-1.08 )"

SRC_TEST="do"
