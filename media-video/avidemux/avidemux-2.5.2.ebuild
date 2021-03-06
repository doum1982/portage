# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avidemux/avidemux-2.5.2.ebuild,v 1.6 2010/10/24 10:00:27 ssuominen Exp $

EAPI="2"

inherit cmake-utils flag-o-matic

MY_P=${PN}_${PV}

DESCRIPTION="Video editor designed for simple cutting, filtering and encoding tasks"
HOMEPAGE="http://fixounet.free.fr/avidemux"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
	mirror://gentoo/avidemux-2.5.1-patches-1.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+aac +aften +alsa amr +dts esd jack libsamplerate +mp3 nls oss
	pulseaudio +sdl +truetype +vorbis +x264 +xv +xvid gtk +qt4"

RDEPEND="dev-libs/libxml2
	aac? ( media-libs/faac
		media-libs/faad2 )
	aften? ( media-libs/aften )
	alsa? ( media-libs/alsa-lib )
	amr? ( media-libs/opencore-amr )
	dts? ( media-libs/libdca )
	mp3? ( media-sound/lame )
	esd? ( media-sound/esound )
	jack? ( media-sound/jack-audio-connection-kit )
	libsamplerate? ( media-libs/libsamplerate )
	pulseaudio? ( media-sound/pulseaudio )
	sdl? ( media-libs/libsdl )
	truetype? ( media-libs/freetype:2
		media-libs/fontconfig )
	vorbis? ( media-libs/libvorbis )
	x264? ( media-libs/x264 )
	xv? ( x11-libs/libXv )
	xvid? ( media-libs/xvid )
	gtk? ( x11-libs/gtk+:2 )
	qt4? ( x11-libs/qt-gui:4 )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-util/pkgconfig
	dev-util/cmake"

S=${WORKDIR}/${MY_P}
BUILD_S=${WORKDIR}/${P}

AVIDEMUX_LANGS="bg ca cs de el es fr it ja pt_BR ru sr sr@latin tr zh_TW"
for L in ${AVIDEMUX_LANGS}; do
	IUSE="${IUSE} linguas_${L}"
done

PATCHES=( "${WORKDIR}/patches/2.5.1-i18n.patch"
	"${WORKDIR}/patches/2.5.1-coreImage-parallel-build.patch"
	"${FILESDIR}/avidemux-2.5.1-build-plugins-fix.patch"
	"${FILESDIR}/avidemux-2.5.2-altivec-bool.patch"
	"${FILESDIR}/2.5.3_field_asm_fix.diff" )

src_prepare() {
	base_src_prepare

	local po_files=
	local qt_ts_files=
	local avidemux_ts_files=
	for lingua in ${LINGUAS}; do
		if has ${lingua} ${AVIDEMUX_LANGS}; then
			if [[ -e ${S}/po/${lingua}.po ]]; then
				po_files="${po_files} \${po_subdir}/${lingua}.po"
			fi
			if [[ -e ${S}/po/qt_${lingua}.ts ]]; then
				qt_ts_files="${qt_ts_files} \${ts_subdir}/qt_${lingua}.ts"
			fi
			if [[ -e ${S}/po/${PN}_${lingua}.ts ]]; then
				avidemux_ts_files="${avidemux_ts_files} \${ts_subdir}/${PN}_${lingua}.ts"
			fi
		fi
	done

	sed -i -e "s!FILE(GLOB po_files .*)!SET(po_files ${po_files})!" \
		"${S}/cmake/Po.cmake" || die "sed failed"
	sed -i -e "s!FILE(GLOB.*qt.*)!SET(ts_files ${qt_ts_files})!" \
	    -e "s!FILE(GLOB.*avidemux.*)!SET(ts_files ${avidemux_ts_files})!" \
		"${S}/cmake/Ts.cmake" || die "sed failed"
}

src_configure() {
	### Add lax vector typing for PowerPC
	if use ppc || use ppc64; then
		append-cflags "-flax-vector-conversions"
	fi

	mycmakeargs="${mycmakeargs}
		-DAVIDEMUX_SOURCE_DIR='${S}'
		-DAVIDEMUX_INSTALL_PREFIX='${BUILD_S}'
		-DAVIDEMUX_CORECONFIG_DIR='${BUILD_S}/config'"

	# CMakeLists.txt
	use gtk || mycmakeargs="${mycmakeargs} -DGTK=0"
	use qt4 || mycmakeargs="${mycmakeargs} -DQT4=0"

	# cmake/admCheckMiscLibs.cmake
	use nls || mycmakeargs="${mycmakeargs} -DGETTEXT=0"
	use sdl || mycmakeargs="${mycmakeargs} -DSDL=0"
	use xv || mycmakeargs="${mycmakeargs} -DXVIDEO=0"

	# cmake/admCheckAudioDeviceLibs.cmake
	use alsa || mycmakeargs="${mycmakeargs} -DALSA=0"
	use esd || mycmakeargs="${mycmakeargs} -DESD=0"
	use jack || mycmakeargs="${mycmakeargs} -DJACK=0"
	use oss || mycmakeargs="${mycmakeargs} -DOSS=0"
	use pulseaudio || mycmakeargs="${mycmakeargs} -DPULSEAUDIOSIMPLE=0"

	# cmake/admCheckAudioEncoderLibs.cmake
	use aften || mycmakeargs="${mycmakeargs} -DAFTEN=0"
	use mp3 || mycmakeargs="${mycmakeargs} -DLAME=0"
	use aac || mycmakeargs="${mycmakeargs} -DFAAC=0"
	use vorbis || mycmakeargs="${mycmakeargs} -DVORBIS=0"

	# plugins/ADM_audioDecoders
	use aac || mycmakeargs="${mycmakeargs} -DFAAD=0"
	use dts || mycmakeargs="${mycmakeargs} -DLIBDCA=0"

	# opencore
	use amr || mycmakeargs="${mycmakeargs} -DOPENCORE_AMRNB=0 -DOPENCORE_AMRWB=0"

	# plugins/ADM_videoFilters
	use truetype || mycmakeargs="${mycmakeargs} -DFREETYPE2=0 -DFONTCONFIG=0"

	# plugins/ADM_videoEncoder
	use xvid || mycmakeargs="${mycmakeargs} -DXVID=0"
	use x264 || mycmakeargs="${mycmakeargs} -DX264=0"

	cmake-utils_src_configure
}

src_compile() {
	# first build the application
	cmake-utils_src_compile
	# and then go on with plugins
	emake -C "${CMAKE_BUILD_DIR}/plugins" || die "building plugins failed"
}

src_install() {
	# install the application
	cmake-utils_src_install
	# install plugins
	emake -C "${CMAKE_BUILD_DIR}/plugins" DESTDIR="${D}" install \
		|| die "installing plugins failed"

	dodoc AUTHORS || die "dodoc failed"
	newicon ${PN}_icon.png ${PN}.png || die "installing icon failed"

	if use qt4; then
		sed -i "s/\(${PN}2_\)gtk/\1qt4/" ${PN}2.desktop || die "sed failed"
		domenu ${PN}2.desktop || die "installing desktop file failed"
	fi

	if use gtk; then
		domenu ${PN}2-gtk.desktop || die "installing desktop file failed"
	fi
}
