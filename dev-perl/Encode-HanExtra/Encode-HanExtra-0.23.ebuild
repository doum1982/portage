# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Encode-HanExtra/Encode-HanExtra-0.23.ebuild,v 1.1 2011/08/15 14:10:46 patrick Exp $

EAPI="2"

MODULE_AUTHOR="AUDREYT"
inherit perl-module

DESCRIPTION="Extra sets of Chinese encodings"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/perl-Encode"
RDEPEND="${DEPEND}"

#SRC_TEST="do"
