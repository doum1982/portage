# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/rc/rc-1.7.1.ebuild,v 1.1 2009/10/02 12:41:59 ssuominen Exp $

EAPI=2

DESCRIPTION="A reimplementation of the Plan 9 shell"
HOMEPAGE="http://rc-shell.slackmatic.org/"
SRC_URI="http://rc-shell.slackmatic.org/release/${P}.tar.gz"

LICENSE="rc"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libedit readline"

RDEPEND="readline? ( sys-libs/readline )
	libedit? ( dev-libs/libedit )"
DEPEND="${RDEPEND}"

src_configure() {
	local myconf="--with-history"
	use readline && myconf="--with-readline"
	use libedit && myconf="--with-editline"

	econf \
		--disable-dependency-tracking \
		${myconf}
}

src_install() {
	into /
	newbin rc rcsh || die
	newman rc.1 rcsh.1
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	ebegin "Updating /etc/shells"
	( grep -v "^/bin/rcsh$" "${ROOT}"etc/shells; echo "/bin/rcsh" ) > "${T}"/shells
	mv -f "${T}"/shells "${ROOT}"etc/shells
	eend $?
}
