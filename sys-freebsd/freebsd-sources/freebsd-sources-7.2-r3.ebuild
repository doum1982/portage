# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-sources/freebsd-sources-7.2-r3.ebuild,v 1.1 2010/01/09 16:38:37 aballier Exp $

inherit bsdmk freebsd flag-o-matic

DESCRIPTION="FreeBSD kernel sources"
SLOT="${PVR}"
KEYWORDS="~sparc-fbsd ~x86-fbsd"

IUSE="symlink"

SRC_URI="mirror://gentoo/${SYS}.tar.bz2"

RDEPEND=">=sys-freebsd/freebsd-mk-defs-7.0"
DEPEND=""

RESTRICT="strip binchecks"

S="${WORKDIR}/sys"

MY_PVR="${PVR}"

[[ ${MY_PVR} == "${RV}" ]] && MY_PVR="${MY_PVR}-r0"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# This replaces the gentoover patch, it doesn't need reapply every time.
	sed -i -e 's:^REVISION=.*:REVISION="'${PVR}'":' \
		-e 's:^BRANCH=.*:BRANCH="Gentoo":' \
		-e 's:^VERSION=.*:VERSION="${TYPE} ${BRANCH} ${REVISION}":' \
		"${S}/conf/newvers.sh"

	# __FreeBSD_cc_version comes from FreeBSD's gcc.
	# on 7.0-RELEASE it's 700003.
	sed -e "s:-D_KERNEL:-D_KERNEL -D__FreeBSD_cc_version=700004:g" \
		-i "${S}/conf/kern.pre.mk" \
		-i "${S}/conf/kmod.mk" || die "Couldn't set __FreeBSD_cc_version"

	epatch "${FILESDIR}/${PN}-7.0-gentoo.patch"
	epatch "${FILESDIR}/${PN}-6.0-flex-2.5.31.patch"
	epatch "${FILESDIR}/${PN}-7.1-asm.patch"
	epatch "${FILESDIR}/${PN}-7.0-werror.patch"
	epatch "${FILESDIR}/${PN}-7.2-sparc64.patch"
	epatch "${FILESDIR}/${PN}-6.1-ntfs.patch"
	epatch "${FILESDIR}/${PN}-7.2-debug-O2.patch"
	epatch "${FILESDIR}/${PN}-7.1-types.h-fix.patch"
	epatch "${FILESDIR}/${PN}-7.1-subnet-route-pr40133.patch"
	epatch "${FILESDIR}/${PN}-7.1-includes.patch"
	epatch "${FILESDIR}/${PN}-7.2-pipe.patch"
	epatch "${FILESDIR}/${PN}-7.2-ipv6.patch"
	epatch "${FILESDIR}/${PN}-7.2-devfs7.patch"
	epatch "${FILESDIR}/${PN}-7.2-null.patch"
	epatch "${FILESDIR}/${PN}-7.2-zfs712.patch"

	# Disable SSP for the kernel
	grep -Zlr -- -ffreestanding "${S}" | xargs -0 sed -i -e \
		"s:-ffreestanding:-ffreestanding $(test-flags -fno-stack-protector -fno-stack-protector-all):g"

	# By adding -DGENTOO_LIVECD to CFLAGS activate this stub
	# vop_whiteout to tmpfs, so it can be used as an overlay
	# unionfs filesystem over the cd9660 readonly filesystem.
	epatch "${FILESDIR}/${PN}-7.0-tmpfs_whiteout_stub.patch"

	# See http://sourceware.org/bugzilla/show_bug.cgi?id=5391
	# ld doesn't provide symbols constructed as the __start_set_(s) ones
	# are on FreeBSD modules.
	# This patch adds code to generate a list of these and adds them
	# as undefined references to ld's commandline to get them.
	# Without this kernel modules will not load.
	epatch "${FILESDIR}/${PN}-7.1-binutils_link.patch"
}

src_compile() {
	einfo "Nothing to compile.."
}

src_install() {
	insinto "/usr/src/sys-${MY_PVR}"
	doins -r "${S}/"*
}

pkg_postinst() {
	if [[ ! -L "${ROOT}/usr/src/sys" ]]; then
		einfo "/usr/src/sys symlink doesn't exist; creating symlink to sys-${MY_PVR}..."
		ln -sf "sys-${MY_PVR}" "${ROOT}/usr/src/sys" || \
			eerror "Couldn't create ${ROOT}/usr/src/sys symlink."
		# just in case...
		[[ -L ""${ROOT}/usr/src/sys-${RV}"" ]] && rm "${ROOT}/usr/src/sys-${RV}"
		ln -sf "sys-${MY_PVR}" "${ROOT}/usr/src/sys-${RV}" || \
			eerror "Couldn't create ${ROOT}/usr/src/sys-${RV} symlink."
	elif use symlink; then
		einfo "Updating /usr/src/sys symlink to sys-${MY_PVR}..."
		rm "${ROOT}/usr/src/sys" "${ROOT}/usr/src/sys-${RV}" || \
			eerror "Couldn't remove previous symlinks, please fix manually."
		ln -sf "sys-${MY_PVR}" "${ROOT}/usr/src/sys" || \
			eerror "Couldn't create ${ROOT}/usr/src/sys symlink."
		ln -sf "sys-${MY_PVR}" "${ROOT}/usr/src/sys-${RV}" || \
			eerror "Couldn't create ${ROOT}/usr/src/sys-${RV} symlink."
	fi

	if use sparc-fbsd ; then
		ewarn "WARNING: kldload currently causes kernel panics"
		ewarn "on sparc64. This is probably a gcc-4.1 issue, but"
		ewarn "we need gcc-4.1 to compile the kernel correctly :/"
		ewarn "Please compile all modules you need into the kernel"
	fi
}
