# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/phpmp/phpmp-0.11.0-r1.ebuild,v 1.2 2010/10/14 15:42:42 fauli Exp $

EAPI="2"

inherit webapp depend.php

MY_PN="phpMp"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="phpMp is a client program for Music Player Daemon (mpd)"
HOMEPAGE="http://www.musicpd.org/"
SRC_URI="mirror://sourceforge/musicpd/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="|| ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )"

need_httpd_cgi
need_php_httpd

S="${WORKDIR}"/${MY_P}

src_install() {
	webapp_src_preinst

	dodoc ChangeLog README TODO
	rm -f ChangeLog COPYING INSTALL README TODO

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_configfile "${MY_HTDOCSDIR}"/config.php

	webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	webapp_src_install
}
