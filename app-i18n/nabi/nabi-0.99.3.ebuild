# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/nabi/nabi-0.99.3.ebuild,v 1.2 2011/03/27 10:54:45 nirbheek Exp $

EAPI="1"

inherit eutils autotools

DESCRIPTION="Simple Hanguk X Input Method"
HOMEPAGE="http://nabi.kldp.net/"
SRC_URI="http://kldp.net/frs/download.php/4929/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=x11-libs/gtk+-2.4:2
	>=app-i18n/libhangul-0.0.8"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${P}-asneeded.patch

	eautoreconf
}

src_compile() {
	local myconf=

	# Broken configure: --disable-debug also enables debug
	use debug && \
		myconf="${myconf} --enable-debug"

	econf ${myconf}
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	elog "You MUST add environment variable..."
	elog
	elog "export XMODIFIERS=\"@im=nabi\""
	elog
}
