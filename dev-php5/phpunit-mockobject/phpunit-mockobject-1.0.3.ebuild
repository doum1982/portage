# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php5/phpunit-mockobject/phpunit-mockobject-1.0.3.ebuild,v 1.3 2011/05/24 14:55:55 hwoarang Exp $

EAPI="2"
inherit php-pear-lib-r1

KEYWORDS="amd64 x86"

DESCRIPTION="Mock Object library for PHPUnit"
HOMEPAGE="http://www.phpunit.de/"
SRC_URI="http://pear.phpunit.de/get/PHPUnit_MockObject-${PV}.tgz"
LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND="!dev-php4/phpunit
	>=dev-php/PEAR-PEAR-1.9.1"
RDEPEND="${DEPEND}
	dev-php5/PEAR-Text_Template"

need_php_by_category

S="${WORKDIR}/PHPUnit_MockObject-${PV}"
