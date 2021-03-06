# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/midori/midori-0.3.6.ebuild,v 1.2 2011/06/17 09:37:29 angelos Exp $

EAPI=3
inherit eutils fdo-mime gnome2-utils python waf-utils

DESCRIPTION="A lightweight web browser based on WebKitGTK+"
HOMEPAGE="http://www.twotoasts.de/index.php?/pages/midori_summary.html"
SRC_URI="mirror://xfce/src/apps/${PN}/0.3/${P}.tar.bz2"

LICENSE="LGPL-2.1 MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~x86-fbsd"
IUSE="doc gnome idn libnotify nls +unique vala"

RDEPEND="dev-libs/libxml2:2
	>=dev-db/sqlite-3.0
	>=net-libs/libsoup-2.25.2:2.4
	net-libs/webkit-gtk:2
	x11-libs/gtk+:2
	gnome? ( net-libs/libsoup-gnome:2.4 )
	idn? ( net-dns/libidn )
	libnotify? ( x11-libs/libnotify )
	unique? ( dev-libs/libunique:1 )"
DEPEND="${RDEPEND}
	|| ( dev-lang/python:2.7 dev-lang/python:2.6 )
	vala? ( dev-lang/vala:0.10 )
	dev-util/intltool
	doc? ( dev-util/gtk-doc )
	nls? ( sys-devel/gettext )"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup

	DOCS=( AUTHORS ChangeLog HACKING INSTALL TODO TRANSLATE )
	HTML_DOCS=( data/faq.html data/faq.css )
}

src_prepare() {
	# Make it work with slotted vala versions
	sed -i -e "s/conf.env, 'valac'/conf.env, 'valac-0.10', var='VALAC'/" wscript || die
}

src_configure() {
	strip-linguas -i po

	waf-utils_src_configure \
		--disable-docs \
		--enable-addons \
		$(use_enable doc apidocs) \
		$(use_enable idn libidn) \
		$(use_enable libnotify) \
		$(use_enable nls) \
		$(use_enable unique) \
		$(use_enable vala)
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
