# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/swig/swig-2.0.4_pre12643.ebuild,v 1.2 2011/04/29 09:24:55 pchrist Exp $

EAPI="3"

DESCRIPTION="Simplified Wrapper and Interface Generator"
HOMEPAGE="http://www.swig.org/"
if [[ "${PV}" == *_pre* ]]; then
	SRC_URI="mirror://gentoo/${P}.tar.bz2"
else
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
fi

LICENSE="GPL-3 as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~x86-fbsd ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="ccache doc pcre"
RESTRICT="test"

DEPEND="pcre? ( dev-libs/libpcre )"
RDEPEND="${DEPEND}"

src_prepare() {
	if [[ "${PV}" == *_pre* ]]; then
		./autogen.sh || die "autogen.sh failed"
	fi
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable ccache) \
		$(use_with pcre)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ANNOUNCE CHANGES CHANGES.current README TODO || die "dodoc failed"
	if use doc; then
		dohtml -r Doc/{Devel,Manual} || die "dohtml failed"
	fi
}
