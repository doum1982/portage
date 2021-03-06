# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Template-XML/Template-XML-2.17-r1.ebuild,v 1.9 2011/05/01 17:33:24 armin76 Exp $

MODULE_AUTHOR=ABW
inherit perl-module

DESCRIPTION="XML plugins for the Template Toolkit"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~arm ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-solaris"
IUSE=""

PATCHES=( "${FILESDIR}/bug-144689-branch-2.17.patch" )

SRC_TEST="do"

DEPEND="dev-lang/perl
	>=dev-perl/Template-Toolkit-2.15-r1
	dev-perl/XML-DOM
	dev-perl/XML-Parser
	dev-perl/XML-RSS
	dev-perl/XML-Simple
	dev-perl/XML-XPath"
