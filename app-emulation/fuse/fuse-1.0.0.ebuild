# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/fuse/fuse-1.0.0.ebuild,v 1.1 2011/05/02 20:01:15 neurogeek Exp $

EAPI="3"

DESCRIPTION="Free Unix Spectrum Emulator by Philip Kendall"
HOMEPAGE="http://fuse-emulator.sourceforge.net"
SRC_URI="mirror://sourceforge/fuse-emulator/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="alsa ao fbcon gpm gtk joystick memlimit png sdl svga X xml"

# This build is heavily use dependent. Fuse user interface use flags are, in
# order of precedence: gtk, sdl, X, svga and fbcon. X version of fuse will
# be built if no valid user interface flag is chosen.
RDEPEND="~app-emulation/libspectrum-1.0.0
	gtk? ( x11-libs/gtk+:2
		alsa? ( media-libs/alsa-lib )
		!alsa? ( ao? ( media-libs/libao ) )
		joystick? ( media-libs/libjsw ) )
	!gtk? (
		sdl? ( >=media-libs/libsdl-1.2.4 )
		!sdl? (
			X? ( x11-libs/libX11
				x11-libs/libXext
				alsa? ( media-libs/alsa-lib )
				!alsa? ( ao? ( media-libs/libao ) )
				joystick? ( media-libs/libjsw ) )
			!X? (
				svga? ( media-libs/svgalib
					alsa? ( media-libs/alsa-lib )
					!alsa? ( ao? ( media-libs/libao ) ) )
				!svga? (
					fbcon? ( virtual/linux-sources
						gpm? ( sys-libs/gpm )
						alsa? ( media-libs/alsa-lib )
						!alsa? ( ao? ( media-libs/libao ) )
						joystick? ( media-libs/libjsw ) )
					!fbcon? ( x11-libs/libX11
						x11-libs/libXext
						alsa? ( media-libs/alsa-lib )
						!alsa? ( ao? ( media-libs/libao ) )
						joystick? ( media-libs/libjsw ) ) ) ) ) )
	dev-libs/glib:2
	png? ( media-libs/libpng )
	xml? ( dev-libs/libxml2 )"
DEPEND="${RDEPEND}
	dev-lang/perl
	dev-util/pkgconfig"

src_configure() {
	local guiflag
	if use gtk; then
		guiflag=""
	elif use sdl; then
		guiflag="--with-sdl"
	elif use X; then
		guiflag="--without-gtk"
	elif use svga; then
		guiflag="--with-svgalib"
	elif use fbcon; then
		guiflag="--with-fb"
	else  # We default to X user interface
		guiflag="--without-gtk"
	fi
	econf --without-win32 \
		${guiflag} \
		$(use_with gpm) \
		$(use_with alsa) \
		$(use_with ao libao) \
		$(use_with joystick) \
		$(use_enable joystick ui-joystick) \
		$(use_with xml libxml2) \
		$(use_with png ) \
		$(use_enable memlimit smallmem) \
		|| die "econf failed!"
}

src_compile() {
	emake || die "emake failed!"
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog README THANKS
	doman man/fuse.1
}
