# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Flat/File-Flat-1.40.0.ebuild,v 1.1 2011/08/30 15:58:10 tove Exp $

EAPI=4

MODULE_AUTHOR=ADAMK
MODULE_VERSION=1.04
inherit perl-module

DESCRIPTION="Implements a flat filesystem"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND=">=dev-perl/Class-Autouse-1
	>=dev-perl/Test-ClassAPI-1.02
	>=dev-perl/File-Copy-Recursive-0.36
	>=dev-perl/File-Remove-0.38
	>=virtual/perl-File-Spec-0.85
	>=virtual/perl-File-Temp-0.17
	>=dev-perl/File-Remove-0.21
	>=dev-perl/File-Slurp-9999.04
	>=dev-perl/prefork-0.02"
DEPEND="${RDEPEND}"

SRC_TEST="do"
