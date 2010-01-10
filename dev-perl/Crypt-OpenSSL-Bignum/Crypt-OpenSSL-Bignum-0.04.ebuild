# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-OpenSSL-Bignum/Crypt-OpenSSL-Bignum-0.04.ebuild,v 1.10 2010/01/09 18:29:12 grobian Exp $

inherit perl-module

DESCRIPTION="OpenSSL's multiprecision integer arithmetic"
HOMEPAGE="http://search.cpan.org/~iroberts/"
SRC_URI="mirror://cpan/authors/id/I/IR/IROBERTS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

SRC_TEST="do"
DEPEND="dev-lang/perl"
