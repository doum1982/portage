# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ecb/ecb-2.40-r1.ebuild,v 1.4 2010/05/23 18:24:13 pacho Exp $

EAPI=3

inherit elisp eutils

DESCRIPTION="Source code browser for Emacs"
HOMEPAGE="http://ecb.sourceforge.net/"
SRC_URI="mirror://sourceforge/ecb/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="java"

DEPEND=">=app-emacs/cedet-1.0_pre6
	java? ( app-emacs/jde )"
RDEPEND="${DEPEND}"

SITEFILE="70${PN}-gentoo.el"

src_prepare() {
	epatch "${FILESDIR}/${PN}-2.32-gentoo.patch"
	sed -i -e "s:@PF@:${PF}:" ecb-help.el || die "sed failed"
}

src_compile() {
	local loadpath="" sl=${EPREFIX}${SITELISP}
	if use java; then
		loadpath="${sl}/elib ${sl}/jde ${sl}/jde/lisp"
	fi

	emake CEDET="${sl}/cedet" LOADPATH="${loadpath}" || die "emake failed"
}

src_install() {
	elisp_src_install

	insinto "${SITEETC}/${PN}"
	doins -r ecb-images || die

	doinfo info-help/ecb.info* || die
	dohtml html-help/*.html || die
	dodoc NEWS README RELEASE_NOTES || die
}

pkg_postinst() {
	elisp-site-regen
	elog "ECB is now autoloaded in site-gentoo.el. Add the line"
	elog "  (require 'ecb)"
	elog "to your ~/.emacs file to enable all features on Emacs startup."
}
