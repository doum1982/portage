# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/x264-encoder/x264-encoder-9999.ebuild,v 1.1 2011/05/28 12:04:21 radhermit Exp $

EAPI=4

if [ "${PV#9999}" != "${PV}" ] ; then
	V_ECLASS="git-2"
else
	V_ECLASS="versionator"
fi

inherit multilib toolchain-funcs ${V_ECLASS}

if [ "${PV#9999}" = "${PV}" ] ; then
	MY_P="x264-snapshot-$(get_version_component_range 3)-2245"
fi
DESCRIPTION="A free commandline encoder for X264/AVC streams"
HOMEPAGE="http://www.videolan.org/developers/x264.html"
if [ "${PV#9999}" != "${PV}" ] ; then
	EGIT_REPO_URI="git://git.videolan.org/x264.git"
	SRC_URI=""
else
	SRC_URI="http://ftp.videolan.org/pub/videolan/x264/snapshots/${MY_P}.tar.bz2"
fi

LICENSE="GPL-2"
SLOT="0"
if [ "${PV#9999}" != "${PV}" ] ; then
	KEYWORDS=""
else
	KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
fi
IUSE="debug ffmpeg mp4 +system-libx264 +threads"

RDEPEND="
	ffmpeg? ( media-video/ffmpeg )
	mp4? ( >=media-video/gpac-0.4.1_pre20060122 )
	system-libx264? ( ~media-libs/x264-${PV} )
"
ASM_DEP=">=dev-lang/yasm-0.6.2"
DEPEND="${RDEPEND}
	amd64? ( ${ASM_DEP} )
	x86? ( || ( ${ASM_DEP} dev-lang/nasm )
		!<dev-lang/yasm-0.6.2 )
	x86-fbsd? ( ${ASM_DEP} )
	dev-util/pkgconfig
"
if [ "${PV#9999}" = "${PV}" ] ; then
	S=${WORKDIR}/${MY_P}
fi

src_configure() {
	tc-export CC

	local myconf=""
	use debug && myconf+=" --enable-debug"
	use ffmpeg || myconf+=" --disable-lavf --disable-swscale"
	use mp4 || myconf+=" --disable-gpac"
	use system-libx264 && myconf+=" --system-libx264"
	use threads || myconf+=" --disable-thread"

	./configure \
		--prefix="${EPREFIX}"/usr \
		--libdir="${EPREFIX}"/usr/$(get_libdir) \
		--disable-avs \
		--disable-ffms \
		--extra-asflags="${ASFLAGS}" \
		--extra-cflags="${CFLAGS}" \
		--extra-ldflags="${LDFLAGS}" \
		--host="${CHOST}" \
		${myconf} \
		|| die
}
