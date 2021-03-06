# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/News-Newsrc/News-Newsrc-1.90.0.ebuild,v 1.1 2011/08/29 11:24:09 tove Exp $

EAPI=4

MODULE_AUTHOR=SWMCD
MODULE_VERSION=1.09
inherit perl-module

DESCRIPTION="Manage newsrc files"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-perl/Set-IntSpan-1.07"
DEPEND="${RDEPEND}"

SRC_TEST="do"
