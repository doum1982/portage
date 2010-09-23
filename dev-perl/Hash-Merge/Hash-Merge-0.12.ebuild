# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Hash-Merge/Hash-Merge-0.12.ebuild,v 1.2 2010/09/22 18:17:04 grobian Exp $

EAPI=2

MODULE_AUTHOR="DMUEY"
inherit perl-module

DESCRIPTION="Merges arbitrarily deep hashes into a single hash"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-macos ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/Clone"
DEPEND="${RDEPEND}"

SRC_TEST=do
