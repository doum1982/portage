# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/djvu/djvu-3.5.23.ebuild,v 1.9 2011/04/16 18:52:09 armin76 Exp $

EAPI="2"
inherit fdo-mime autotools flag-o-matic

MY_P="${PN}libre-${PV#*_p}"

DESCRIPTION="DjVu viewers, encoders and utilities"
HOMEPAGE="http://djvu.sourceforge.net"
SRC_URI="mirror://sourceforge/djvu/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="debug doc jpeg nls tiff xml"

RDEPEND="jpeg? ( virtual/jpeg )
	tiff? ( media-libs/tiff )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

# No gui, only manual pages left and only on ja...
LANGS="ja"
IUSE+=" $(printf "linguas_%s" ${LANGS})"

src_prepare() {
	sed 's/AC_CXX_OPTIMIZE/OPTS=;AC_SUBST(OPTS)/' -i configure.ac || die #263688
	rm aclocal.m4 config/{libtool.m4,ltmain.sh,install-sh}
	AT_M4DIR="config" eautoreconf
}

src_configure() {
	local X I18N
	if use nls; then
		for X in ${LANGS}; do
			if use linguas_${X}; then
				I18N="${I18N} ${X}"
			fi
		done
		I18N="${I18N# }"
		if test -n "$I18N"; then
			I18N="--enable-i18n=${I18N}"
		else
			I18N="--enable-i18n"
		fi
	else
		I18N="--disable-i18n"
	fi

	use debug && append-cppflags "-DRUNTIME_DEBUG_ONLY"

	# We install all desktop files by hand.
	econf --disable-desktopfiles \
		--without-qt \
		$(use_enable xml xmltools) \
		$(use_with jpeg) \
		$(use_with tiff) \
		"${I18N}"
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc README TODO NEWS

	use doc && cp -r doc/ "${D}"/usr/share/doc/${PF}

	# Install desktop files.
	cd desktopfiles
	for i in {22,32,48}; do
		insinto /usr/share/icons/hicolor/${i}x${i}/mimetypes
		newins hi${i}-djvu.png image-vnd.djvu.png || die
	done
	insinto /usr/share/mime/packages
	doins djvulibre-mime.xml || die
}

pkg_postinst() {
	fdo-mime_mime_database_update
	elog "For djviewer or browser plugin, emerge app-text/djview4."
}

pkg_postrm() {
	fdo-mime_mime_database_update
}
