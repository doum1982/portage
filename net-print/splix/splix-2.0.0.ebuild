# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/splix/splix-2.0.0.ebuild,v 1.5 2011/05/13 22:17:48 voyageur Exp $

EAPI=2
inherit eutils toolchain-funcs

MY_P=${PN}-${PV/_p/-}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A set of CUPS printer drivers for SPL (Samsung Printer Language) printers"
HOMEPAGE="http://splix.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2
	http://splix.ap2c.org/samsung_cms.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+jbig"

DEPEND="<app-text/ghostscript-gpl-9.02
	|| ( >=net-print/cups-1.4.0 net-print/cupsddk )
	jbig? ( media-libs/jbigkit )"
RDEPEND="${DEPEND}"

src_prepare() {
	# http://sourceforge.net/tracker/?func=detail&aid=2880411&group_id=175815&atid=874748
	epatch "${FILESDIR}"/${P}-algo0x0d_one_scanline_over_fix.patch

	epatch "${FILESDIR}"/${P}-gcc45.patch
	# Honor LDFLAGS
	sed -e "/[a-z]_LDFLAGS/s/:=.*/:= $\{LDFLAGS\}/" -i module.mk \
		|| die "module.mk sed failed"
	# Correct link comand, do not strip on install
	sed -e "s/g++/$\{LINKER\}/" -e "/install/s/-s //" -i rules.mk \
		|| die "rules.mk sed failed"
}

src_compile() {
	local options="MODE=optimized"
	use jbig || options="${options} DISABLE_JBIG=1"
	emake ${options} CXX="$(tc-getCXX)" \
		OPTIM_CFLAGS="${CFLAGS}" OPTIM_CXXFLAGS="${CXXFLAGS}" \
		|| die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	gzip "${D}"/$(cups-config --datadir)/model/*/*.ppd || die "ppd gzip failed"

	insinto $(cups-config --datadir)/model/samsung
	doins -r "${WORKDIR}"/cms
}

pkg_postinst() {
	ewarn "You *MUST* make sure that the PPD files that CUPS is using"
	ewarn "for actually installed printers are updated if you upgraded"
	ewarn "from a previous version of splix!"
	ewarn "Otherwise you will be unable to print (your printer might"
	ewarn "spit out blank pages etc.)."
	ewarn "To do that, simply delete the corresponding PPD file in"
	ewarn "/etc/cups/ppd/, click on 'Modify Printer' belonging to the"
	ewarn "corresponding printer in the CUPS webinterface (usually"
	ewarn "reachable via http://localhost:631/) and choose the correct"
	ewarn "printer make and model, for example:"
	ewarn "'Samsung' -> 'Samsung ML-1610, 1.0 (en)'"
}
