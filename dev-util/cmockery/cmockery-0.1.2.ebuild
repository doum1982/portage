# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cmockery/cmockery-0.1.2.ebuild,v 1.7 2011/08/24 14:05:48 darkside Exp $

EAPI=4

inherit autotools

DESCRIPTION="A lightweight library to simplify writing unit tests for C applications"
HOMEPAGE="http://code.google.com/p/cmockery/"
SRC_URI="http://cmockery.googlecode.com/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~s390 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="examples static-libs"

DEPEND=""
RDEPEND=""

src_prepare() {
	sed -i -e "/dist_doc_DATA/{N;d}" Makefile.am
	AT_M4DIR="m4" eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	dohtml doc/*

	if use examples ; then
		docinto examples
		dodoc src/example/*
		docompress -x /usr/share/doc/${PF}/examples
	fi

	use static-libs || find "${ED}" -name '*.la' -exec rm -f '{}' +
}
