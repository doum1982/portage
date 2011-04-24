# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-Date/HTTP-Date-6.0.0.ebuild,v 1.4 2011/04/24 11:41:46 grobian Exp $

EAPI=3

MODULE_AUTHOR=GAAS
MODULE_VERSION=6.00
inherit perl-module

DESCRIPTION="Date conversion for HTTP date formats"

SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86 ~ppc-aix ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="
	!<dev-perl/libwww-perl-6
	virtual/perl-Time-Local
"
DEPEND="${RDEPEND}"

SRC_TEST=do
