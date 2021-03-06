# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/guvcview/guvcview-1.5.0.ebuild,v 1.1 2011/08/22 05:32:09 radhermit Exp $

EAPI=4

inherit autotools

MY_P=${PN}-src-${PV}
DESCRIPTION="GTK+ UVC Viewer"
HOMEPAGE="http://guvcview.berlios.de"
SRC_URI="mirror://berlios/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pulseaudio"

RDEPEND=">=dev-libs/glib-2.10:2
	virtual/ffmpeg
	>=media-libs/libsdl-1.2.10
	>=media-libs/libpng-1.4
	media-libs/libv4l
	>=media-libs/portaudio-19_pre
	sys-fs/udev
	>=x11-libs/gtk+-2.14:2
	pulseaudio? ( >=media-sound/pulseaudio-0.9.15 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i -e '/^guvcviewdocdir/,/^$/d' Makefile.am || die
	eautoreconf
}

src_configure() {
	econf \
		--disable-debian-menu \
		$(use_enable pulseaudio pulse)
}
