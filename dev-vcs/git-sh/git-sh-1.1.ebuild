# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/git-sh/git-sh-1.1.ebuild,v 1.1 2011/03/27 15:06:22 ayoy Exp $

EAPI="2"

DESCRIPTION="A customized bash environment suitable for git work."
HOMEPAGE="http://github.com/rtomayko/git-sh"
SRC_URI="http://github.com/rtomayko/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-vcs/git"

S="${WORKDIR}/rtomayko-${PN}-a59681d"

src_prepare() {
	sed -e 's/git-completion\.bash //' \
	    -e 's:/local::' -i Makefile || die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CHANGES README.markdown || die "dodoc failed"
}

pkg_postinst() {
	einfo
	einfo "For bash completion in git commands emerge dev-vcs/git"
	einfo "with bash-completion USE flag."
	einfo
}
