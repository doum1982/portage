# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-DesktopEntry/File-DesktopEntry-0.04.ebuild,v 1.19 2011/08/17 16:45:31 chithanh Exp $

EAPI=3

MODULE_AUTHOR=PARDUS
MODULE_SECTION=${PN}

inherit perl-module

DESCRIPTION="Object to handle .desktop files"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~sparc-solaris"
IUSE="test"

RDEPEND="virtual/perl-File-Spec
	>=dev-perl/File-BaseDir-0.03"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( virtual/perl-Test-Simple
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
