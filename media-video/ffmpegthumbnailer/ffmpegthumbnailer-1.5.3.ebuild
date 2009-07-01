# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ffmpegthumbnailer/ffmpegthumbnailer-1.5.3.ebuild,v 1.5 2009/06/30 14:03:36 armin76 Exp $

EAPI=2

DESCRIPTION="Lightweight video thumbnailer that can be used by file managers"
HOMEPAGE="http://code.google.com/p/ffmpegthumbnailer"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 ~ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="jpeg png"

RDEPEND=">=media-video/ffmpeg-0.5
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-static \
		$(use_enable png) \
		$(use_enable jpeg)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
	find "${D}"/usr -name '*.la' -delete
}
