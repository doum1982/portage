# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phploc/phploc-1.6.1.ebuild,v 1.2 2011/04/16 12:48:09 olemarkus Exp $

EAPI="3"
PHP_PEAR_CHANNEL="${FILESDIR}/channel.xml"
PHP_PEAR_PN="phploc"
inherit php-pear-lib-r1

DESCRIPTION="A tool for quickly measuring the size of a PHP project"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
HOMEPAGE="http://www.phpunit.de"

RDEPEND="${RDEPEND}
	>=dev-php/file-iterator-1.1.0
	>=dev-php5/ezc-ConsoleTools-1.6.0"
