# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gtkpod/gtkpod-2.0.0.ebuild,v 1.4 2011/04/08 21:09:56 ssuominen Exp $

EAPI=2
inherit gnome2-utils

DESCRIPTION="A graphical user interface to the Apple productline"
HOMEPAGE="http://gtkpod.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aac curl flac gstreamer mp3 ogg webkit"

COMMON_DEPEND=">=dev-libs/glib-2.15.0:2
	>=dev-util/anjuta-2.30
	=dev-util/anjuta-2*
	>=gnome-base/libglade-2.4.0
	>=media-libs/libgpod-0.7.0
	>=media-libs/libid3tag-0.15
	>=x11-libs/gtk+-2.21.0:2
	aac? ( media-libs/faad2
		media-libs/libmp4v2 )
	curl? ( >=net-misc/curl-7.10 )
	flac? ( media-libs/flac )
	gstreamer? ( >=media-libs/gst-plugins-base-0.10.25:0.10 )
	mp3? ( media-sound/lame )
	ogg? ( media-libs/libvorbis
		media-sound/vorbis-tools )
	webkit? ( >=net-libs/webkit-gtk-1.1:2 )"
RDEPEND="${COMMON_DEPEND}
	gstreamer? ( media-plugins/gst-plugins-meta:0.10 )"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-kernel/linux-headers
	sys-devel/flex
	sys-devel/gettext"

src_prepare() {
	sed -i \
		-e 's:-DG_DISABLE_DEPRECATED -DGDK_PIXBUF_DISABLE_DEPRECATED::' \
		-e 's:-DGDK_DISABLE_DEPRECATED -DGTK_DISABLE_DEPRECATED::' \
		configure || die
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-static \
		$(use_enable webkit plugin-coverweb) \
		$(use_enable gstreamer plugin-media-player) \
		$(use_with curl) \
		$(use_with ogg) \
		$(use_with flac) \
		$(use_with aac faad)
}

src_install() {
	emake \
		DESTDIR="${D}" \
		docdir=/usr/share/doc/${PF}/html \
		figuresdir=/usr/share/doc/${PF}/html/figures \
		install || die

	dodoc AUTHORS ChangeLog NEWS README TODO TODOandBUGS.txt TROUBLESHOOTING || die

	find "${D}" -name '*.la' -exec rm -f {} +
	rm -f "${D}"/usr/share/gtkpod/data/{AUTHORS,COPYING}
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
