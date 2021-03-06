# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tk-JPEG-Lite/Tk-JPEG-Lite-2.01403.ebuild,v 1.13 2011/02/25 20:13:37 signals Exp $

EAPI=3

MODULE_AUTHOR=SREZIC
inherit perl-module

DESCRIPTION="lite JPEG loader for Tk::Photo"

SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE=""

RDEPEND="virtual/jpeg
	dev-perl/perl-tk"
DEPEND="${RDEPEND}"

src_prepare() {
	perl-module_src_prepare
	sed -i -e 's:tkjpeg:tkjpeg-lite:' Makefile.PL tkjpeg MANIFEST || die
	mv tkjpeg tkjpeg-lite || die
}

pkg_postinst() {
	elog
	elog "To avoid collisions, the command line program has been renamed from tkjpeg to tkjpeg-lite"
	elog
}
