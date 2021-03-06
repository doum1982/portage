# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gst-plugins-base/gst-plugins-base-0.10.35.ebuild,v 1.3 2011/08/25 18:29:37 nirbheek Exp $

EAPI="3"
GCONF_DEBUG="no"

# order is important, gnome2 after gst-plugins
inherit gst-plugins-base gst-plugins10 gnome2 flag-o-matic eutils
# libtool

DESCRIPTION="Basepack of plugins for gstreamer"
HOMEPAGE="http://gstreamer.freedesktop.org/"
SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~amd64-linux ~arm ~hppa ~ia64 ~mips ~ppc ~ppc-macos ~ppc64 ~sh ~sparc ~sparc-solaris ~x64-macos ~x64-solaris ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~x86-linux ~x86-macos ~x86-solaris"
IUSE="+introspection nls +orc"

RDEPEND=">=dev-libs/glib-2.22:2
	>=media-libs/gstreamer-0.10.34:0.10[introspection?]
	dev-libs/libxml2:2
	app-text/iso-codes
	introspection? ( >=dev-libs/gobject-introspection-0.9.12 )
	orc? ( >=dev-lang/orc-0.4.11 )
	!<media-libs/gst-plugins-bad-0.10.10"
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.11.5 )
	dev-util/pkgconfig"
	# Only if running eautoreconf: dev-util/gtk-doc-am

GST_PLUGINS_BUILD=""

DOCS="AUTHORS NEWS README RELEASE"

src_configure() {
	gst-plugins-base_src_configure \
		$(use_enable introspection) \
		$(use_enable nls) \
		$(use_enable orc) \
		--disable-examples \
		--disable-debug
}

src_compile() {
	# gst doesnt handle opts well, last tested with 0.10.15
	strip-flags
	replace-flags "-O3" "-O2"
	emake || die "emake failed."
}

src_install() {
	gnome2_src_install
}
