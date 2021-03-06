# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/znc/znc-0.096-r1.ebuild,v 1.1 2011/03/03 23:51:31 wired Exp $

EAPI=2

inherit base

DESCRIPTION="An advanced IRC Bouncer"
HOMEPAGE="http://znc.sourceforge.net"
SRC_URI="http://znc.in/releases/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="ares debug extras ipv6 perl ssl sasl tcl"

RDEPEND="
	ares? ( >=net-dns/c-ares-1.5 )
	perl? ( dev-lang/perl )
	sasl? ( >=dev-libs/cyrus-sasl-2 )
	ssl? ( >=dev-libs/openssl-0.9.7d )
	tcl? ( dev-lang/tcl )
"
DEPEND="
	dev-util/pkgconfig
	perl? ( dev-lang/swig )
	${RDEPEND}
"
PATCHES=(
	# https://github.com/znc/znc/commit/ddd302fbf549bac9cbd9b6675b145ddf0a802aa7
	"${FILESDIR}"/"${P}"-clearbuffersonmsg-fix.patch
)

src_configure() {
	econf \
		$(use_enable ares c-ares) \
		$(use_enable debug) \
		$(use_enable extras extra) \
		$(use_enable ipv6) \
		$(use_enable perl) \
		$(use_enable sasl) \
		$(use_enable ssl openssl) \
		$(use_enable tcl tcl) \
		|| die "econf failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed."
	dodoc AUTHORS README || die "dodoc failed"
}

pkg_postinst() {
	elog
	elog "Run 'znc --makeconf' as the user you want to run ZNC as"
	elog "to make a configuration file"
	elog "If you are using SSL you should also run 'znc --makepem'"
	elog
}
