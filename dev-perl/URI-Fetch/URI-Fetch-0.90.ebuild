# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/URI-Fetch/URI-Fetch-0.90.ebuild,v 1.1 2011/01/29 08:23:03 tove Exp $

EAPI=3

MODULE_AUTHOR=BTROTT
MODULE_VERSION=0.09
inherit perl-module

DESCRIPTION="Smart URI fetching/caching"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-perl/Class-ErrorHandler
	virtual/perl-IO-Compress
	dev-perl/libwww-perl
	virtual/perl-Storable
	dev-perl/URI
"
DEPEND="${RDEPEND}"

SRC_TEST=online
