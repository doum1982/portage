# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/libreadline-java/libreadline-java-0.8.0-r3.ebuild,v 1.2 2010/10/14 16:10:06 phajdan.jr Exp $

JAVA_PKG_IUSE="doc source"
EAPI=2

inherit java-pkg-2 eutils

DESCRIPTION="A JNI-wrapper to GNU Readline."
HOMEPAGE="http://java-readline.sourceforge.net/"
SRC_URI="mirror://sourceforge/java-readline/${P}-src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 x86 ~x86-fbsd"
IUSE="elibc_FreeBSD"

COMMON_DEP="sys-libs/ncurses"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	${COMMON_DEP}"
RESTRICT="test"

java_prepare() {
	epatch "${FILESDIR}/termcap-to-ncurses.patch"
	# bug #157387, reported upstream
	epatch "${FILESDIR}/${P}-gmake.patch"

	# bug #157390
	sed -i "s/^\(JC_FLAGS =\)/\1 $(java-pkg_javac-args)/" Makefile || die
	if use elibc_FreeBSD; then
		sed -i -e '/JAVANATINC/s:linux:freebsd:' Makefile || die "sed JAVANATINC failed"
	fi

	#Respect LDFLAGS bug #336302
	epatch "${FILESDIR}"/${P}-ldflags.patch
}

src_compile() {
	emake -j1 || die "failed to compile"
	if use doc; then
		emake -j1 apidoc || die "failed to generate docs"
	fi
}

src_install() {
	java-pkg_doso *.so
	java-pkg_dojar *.jar
	use source && java-pkg_dosrc src/*
	use doc && java-pkg_dojavadoc api
	dodoc ChangeLog NEWS README README.1st TODO || die
}
