# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/file-roller/file-roller-3.0.2-r1.ebuild,v 1.1 2011/08/19 15:41:36 nirbheek Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
GNOME_TARBALL_SUFFIX="bz2"

inherit eutils gnome2

DESCRIPTION="Archive manager for GNOME"
HOMEPAGE="http://fileroller.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
IUSE="nautilus packagekit"
KEYWORDS="~amd64 ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux"

RDEPEND=">=dev-libs/glib-2.25.5:2
	>=x11-libs/gtk+-3.0.2:3
	sys-apps/file
	nautilus? ( >=gnome-base/nautilus-3.0.0 )
	packagekit? ( app-admin/packagekit-base )
"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.40.0
	dev-util/pkgconfig
	app-text/gnome-doc-utils"
# eautoreconf needs:
#	gnome-base/gnome-common

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-dependency-tracking
		--disable-scrollkeeper
		--disable-run-in-place
		--disable-static
		--disable-deprecations
		--disable-schemas-compile
		--enable-magic
		$(use_enable nautilus nautilus-actions)
		$(use_enable packagekit)"
	DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README TODO"
}

src_prepare() {
	gnome2_src_prepare

	# Use absolute path to GNU tar since star doesn't have the same
	# options. On Gentoo, star is /usr/bin/tar, GNU tar is /bin/tar
	epatch "${FILESDIR}"/${PN}-2.10.3-use_bin_tar.patch

	# Upstream patch to fix path parsing in 7z files, will be in next release
	epatch "${FILESDIR}/${P}-pointer-arithmetic.patch"
}

pkg_postinst() {
	gnome2_pkg_postinst

	elog "${PN} is a frontend for several archiving utilities. If you want a"
	elog "particular achive format support, see ${HOMEPAGE}"
	elog "and install the relevant package."
	elog
	elog "for example:"
	elog "  7-zip   - app-arch/p7zip"
	elog "  ace     - app-arch/unace"
	elog "  arj     - app-arch/arj"
	elog "  cpio    - app-arch/cpio"
	elog "  deb     - app-arch/dpkg"
	elog "  iso     - app-cdr/cdrtools"
	elog "  jar,zip - app-arch/zip and app-arch/unzip"
	elog "  lha     - app-arch/lha"
	elog "  lzma    - app-arch/xz-utils"
	elog "  lzop    - app-arch/lzop"
	elog "  rar     - app-arch/unrar"
	elog "  rpm     - app-arch/rpm"
	elog "  unstuff - app-arch/stuffit"
	elog "  zoo     - app-arch/zoo"
}
