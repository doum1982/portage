# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/mt_gtk_client/mt_gtk_client-0.1.98.ebuild,v 1.8 2011/01/24 22:25:30 mr_bones_ Exp $

EAPI=2
inherit games

DESCRIPTION="client for the french tarot game maitretarot"
HOMEPAGE="http://www.nongnu.org/maitretarot/"
SRC_URI="http://savannah.nongnu.org/download/maitretarot/${PN}.pkg/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="gnome"

DEPEND="dev-libs/glib:2
	dev-libs/libxml2
	dev-games/libmaitretarot
	dev-games/libmt_client
	gnome-base/libgnomeui
	x11-libs/gtk+:2"
RDEPEND="${DEPEND}
	dev-games/cardpics"

src_configure() {
	egamesconf $(use_enable gnome gnome2)
}

src_install() {
	emake DESTDIR="${D}" install || die
	mv "${D}"/${GAMES_DATADIR}/locale "${D}"/usr/share/ || die
	dodoc AUTHORS ChangeLog NEWS README TODO
	prepgamesdirs
}
