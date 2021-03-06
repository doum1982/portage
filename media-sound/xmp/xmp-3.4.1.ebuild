# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmp/xmp-3.4.1.ebuild,v 1.1 2011/08/14 00:21:44 radhermit Exp $

EAPI=4

DESCRIPTION="Extended Module Player"
HOMEPAGE="http://xmp.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa audacious nas oss pulseaudio"

DEPEND="alsa? ( media-libs/alsa-lib )
	nas? ( media-libs/nas )
	audacious? ( media-sound/audacious )
	pulseaudio? ( media-sound/pulseaudio )"

src_configure() {
	econf \
		$(use_enable alsa) \
		$(use_enable nas) \
		$(use_enable oss) \
		$(use_enable pulseaudio) \
		$(use_enable audacious audacious-plugin)
}

src_install() {
	default

	doman docs/xmp.1
	rm -f docs/{COPYING,Makefile,xmp.1}
	dodoc -r docs/*
}
