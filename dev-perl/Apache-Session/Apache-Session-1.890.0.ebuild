# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-Session/Apache-Session-1.890.0.ebuild,v 1.1 2011/09/01 13:45:40 tove Exp $

EAPI=4

MODULE_AUTHOR=CHORNY
MODULE_VERSION=1.89
inherit perl-module

DESCRIPTION="Perl module for Apache::Session"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="
	virtual/perl-Digest-MD5
	virtual/perl-Storable"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
"
#	test? (
#		dev-perl/Test-Deep
#		dev-perl/Test-Exception
#	)
