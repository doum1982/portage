# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-All/IO-All-0.420.0.ebuild,v 1.1 2011/07/19 13:07:40 tove Exp $

EAPI=4

MODULE_AUTHOR=INGY
MODULE_VERSION=0.42
inherit perl-module

DESCRIPTION="unified IO operations"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/IO-String"
DEPEND="${RDEPEND}"

SRC_TEST=do
