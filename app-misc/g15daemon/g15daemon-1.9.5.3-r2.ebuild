# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/g15daemon/g15daemon-1.9.5.3-r2.ebuild,v 1.3 2009/03/26 11:35:20 scarabeus Exp $

EAPI=2

inherit eutils linux-info perl-module python multilib base

DESCRIPTION="G15daemon takes control of the G15 keyboard, through the linux kernel uinput device driver"
HOMEPAGE="http://g15daemon.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE="perl python"

DEPEND="dev-libs/libusb
	>=dev-libs/libg15-1.2.4
	>=dev-libs/libg15render-1.2
	perl? ( >=dev-perl/Inline-0.4 )
	python? ( dev-lang/python )"

RDEPEND="${DEPEND}
	perl? ( dev-perl/GDGraph )"

PATCHES=( "${FILESDIR}/${P}-forgotten-open-mode.patch" )
uinput_check() {
	ebegin "Checking for uinput support"
	linux_chkconfig_present INPUT_UINPUT
	eend $?

	if [[ $? -ne 0 ]] ; then
		eerror "To use g15daemon, you need to compile your kernel with uinput support."
		eerror "Please enable uinput support in your kernel config, found at:"
		eerror
		eerror "Device Drivers -> Input Device ... -> Miscellaneous devices -> User level driver support."
		eerror
		eerror "Once enabled, you should have the /dev/input/uinput device."
		eerror "g15daemon will not work without the uinput device."
		die "INPUT_UINPUT support not detected!"
	fi
}

pkg_setup() {
	linux-info_pkg_setup
	uinput_check
}

src_unpack() {
	unpack ${A}
	if use perl; then
		unpack "./${P}/lang-bindings/perl-G15Daemon-0.2.tar.gz"
	fi
	if use python; then
		unpack "./${P}/lang-bindings/pyg15daemon-0.0.tar.bz2"
	fi
}

src_compile() {
	emake || die "make failed"

	if use perl; then
		cd "${WORKDIR}/G15Daemon-0.2"
		perl-module_src_compile
	fi
}

src_install() {
	emake DESTDIR="${D}" \
		docdir=/usr/share/doc/${PF} install || die "make install failed"

	# remove odd docs installed my make
	rm "${D}/usr/share/doc/${PF}/"{LICENSE,README.usage}

	insinto /usr/share/${PN}/contrib
	doins contrib/xmodmaprc
	doins contrib/xmodmap.sh
	if use perl; then
		doins contrib/testbindings.pl
	fi

	newconfd "${FILESDIR}/${PN}-1.2.7.confd" ${PN}
	newinitd "${FILESDIR}/${PN}-1.2.7-r2.initd" ${PN}
	dobin "${FILESDIR}/g15daemon-hotplug"
	insinto /etc/udev/rules.d
	doins "${FILESDIR}/99-g15daemon.rules"

	insinto /etc
	doins "${FILESDIR}"/g15daemon.conf

	if use perl; then
		ebegin "Installing Perl Bindings (G15Daemon.pm)"
		cd "${WORKDIR}/G15Daemon-0.2"
		docinto perl
		perl-module_src_install
	fi

	if use python; then
		ebegin "Installing Python Bindings (g15daemon.py)"
		cd "${WORKDIR}/pyg15daemon"
		python_version

		insinto /usr/$(get_libdir)/python${PYVER}/site-packages/g15daemon
		doins g15daemon.py

		docinto python
		dodoc AUTHORS
	fi
}

pkg_postinst() {
	if use python; then
		python_version
		python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/g15daemon
		echo ""
	fi

	elog "To use g15daemon, you need to add g15daemon to the default runlevel."
	elog "This can be done with:"
	elog "# /sbin/rc-update add g15daemon default"
	elog "You can edit some g15daemon options at /etc/conf.d/g15daemon"
	elog ""
	elog "To have all new keys working in X11, you'll need create a "
	elog "specific xmodmap in your home directory or edit the existent one."
	elog ""
	elog "Create the xmodmap:"
	elog "cp /usr/share/g15daemon/contrib/xmodmaprc ~/.Xmodmap"
	elog ""
	elog "Adding keycodes to an existing xmodmap:"
	elog "cat /usr/share/g15daemon/contrib/xmodmaprc >> ~/.Xmodmap"
}

pkg_postrm() {
	if use python; then
		python_mod_cleanup "/usr/$(get_libdir)/python*/site-packages/g15daemon"
	fi
}
