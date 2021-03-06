# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Any-Moose/Any-Moose-0.13.ebuild,v 1.7 2010/10/28 18:51:44 grobian Exp $

EAPI=3

MODULE_AUTHOR=SARTAK
inherit perl-module

DESCRIPTION="Use Moose or Mouse modules"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86 ~ppc-macos"
IUSE=""

RDEPEND="|| ( >=dev-perl/Mouse-0.40 dev-perl/Moose )
	virtual/perl-version"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31"

SRC_TEST=do
