# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-termios/ruby-termios-0.9.4.ebuild,v 1.18 2009/08/22 22:31:18 a3li Exp $

RUBY_BUG_145222=yes
inherit ruby eutils

DESCRIPTION="A Ruby interface to termios"
HOMEPAGE="http://arika.org/ruby/termios"	# trailing / isn't needed
SRC_URI="http://arika.org/archive/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ~ppc ~sparc x86"
IUSE="examples"
USE_RUBY="ruby18"
DEPEND="virtual/ruby"

src_unpack()
{
	unpack ${A}
	epatch "${FILESDIR}"/ruby-termios-ruby19.patch
}

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog README termios.rd
	docinto examples
	dodoc examples/*
}
