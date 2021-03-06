# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-svg/qt-svg-4.6.3.ebuild,v 1.8 2011/08/17 16:58:53 chithanh Exp $

EAPI="2"
inherit qt4-build

DESCRIPTION="The SVG module for the Qt toolkit"
SLOT="4"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="iconv"

DEPEND="~x11-libs/qt-gui-${PV}[aqua=,debug=]"
RDEPEND="${DEPEND}"

QT4_TARGET_DIRECTORIES="
src/svg
src/plugins/imageformats/svg
src/plugins/iconengines/svgiconengine"
QT4_EXTRACT_DIRECTORIES="${QT4_TARGET_DIRECTORIES}
include/QtSvg/
include/Qt/
include/QtGui/
include/QtCore/
include/QtXml/
src/corelib/
src/gui/
src/plugins/
src/xml
src/3rdparty"

QCONFIG_ADD="svg"
QCONFIG_DEFINE="QT_SVG"

src_configure() {
	myconf="${myconf} $(qt_use iconv) -svg -no-xkb  -no-fontconfig -no-xrender -no-xrandr
		-no-xfixes -no-xcursor -no-xinerama -no-xshape -no-sm -no-opengl
		-no-nas-sound -no-dbus -no-cups -no-nis -no-gif -no-libpng
		-no-libmng -no-libjpeg -no-openssl -system-zlib -no-webkit -no-phonon
		-no-qt3support -no-xmlpatterns -no-freetype -no-libtiff -no-accessibility
		-v -no-fontconfig -no-glib -no-opengl -no-gtkstyle -continue"
	qt4-build_src_configure
}
