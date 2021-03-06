# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/ct-ng/ct-ng-1.12.1.ebuild,v 1.1 2011/08/24 09:39:49 blueness Exp $

inherit bash-completion

DESCRIPTION="crosstool-ng is a tool to build cross-compiling toolchains"
HOMEPAGE="http://ymorin.is-a-geek.org/projects/crosstool"
MY_P=${P/ct/crosstool}
S=${WORKDIR}/${MY_P}
SRC_URI="http://ymorin.is-a-geek.org/download/crosstool-ng/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bash-completion"

RDEPEND="net-misc/curl
	dev-vcs/cvs
	dev-vcs/subversion"

src_install() {
	emake DESTDIR="${D%/}" install || die "install failed"
	dobashcompletion ct-ng.comp
	dodoc README TODO
}
