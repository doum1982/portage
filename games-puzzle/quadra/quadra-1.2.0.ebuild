# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/quadra/quadra-1.2.0.ebuild,v 1.1 2009/08/02 03:21:04 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="A tetris clone with multiplayer support"
HOMEPAGE="http://code.google.com/p/quadra/"
SRC_URI="http://quadra.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libXpm
	x11-libs/libXxf86vm
	x11-libs/libXext
	media-libs/libpng"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

src_prepare() {
	sed -i \
		-e "/^libgamesdir:=/s:/games:/${PN}:" \
		-e "/^datagamesdir:=/s:/games:/${PN}:" config/config.mk.in \
			|| die "sed config/config.mk.in failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}"/${PN}
	doins ${PN}.res || die "doins failed"
	doicon images/${PN}.xpm
	make_desktop_entry ${PN} Quadra

	dodoc ChangeLog NEWS README
	dohtml help/*
	prepgamesdirs
}
