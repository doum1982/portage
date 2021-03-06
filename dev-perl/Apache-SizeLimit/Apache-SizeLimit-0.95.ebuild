# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-SizeLimit/Apache-SizeLimit-0.95.ebuild,v 1.6 2011/08/09 15:49:46 xarthisius Exp $

EAPI="3"

MODULE_AUTHOR="PHRED"

inherit perl-module

DESCRIPTION="Graceful exit for large children"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

# mod_perl < 2.0.5 bundles Apache-SizeLimit
DEPEND="dev-lang/perl
	dev-perl/Linux-Pid
	!<www-apache/mod_perl-2.0.5
	>=www-apache/mod_perl-2.0.5"
RDEPEND="${DEPEND}"

src_prepare() {
	# https://rt.cpan.org/Public/Bug/Display.html?id=66894
	epatch "${FILESDIR}/${P}-Fix_Linux-Smaps_detection.patch"
}
