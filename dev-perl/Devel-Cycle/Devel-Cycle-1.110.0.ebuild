# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Cycle/Devel-Cycle-1.110.0.ebuild,v 1.1 2011/08/31 12:26:59 tove Exp $

EAPI=4

MODULE_AUTHOR=LDS
MODULE_VERSION=1.11
inherit perl-module

DESCRIPTION="Find memory cycles in objects"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

SRC_TEST="do"
