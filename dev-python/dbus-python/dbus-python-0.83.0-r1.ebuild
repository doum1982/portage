# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dbus-python/dbus-python-0.83.0-r1.ebuild,v 1.3 2009/08/02 00:45:44 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit python multilib

DESCRIPTION="Python bindings for the D-Bus messagebus."
HOMEPAGE="http://www.freedesktop.org/wiki/Software/DBusBindings \
http://dbus.freedesktop.org/doc/dbus-python/"
SRC_URI="http://dbus.freedesktop.org/releases/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="examples test"

RDEPEND=">=dev-lang/python-2.4.4-r5
	>=dev-python/pyrex-0.9.3-r2
	>=dev-libs/dbus-glib-0.71
	>=sys-apps/dbus-1.1.1"

DEPEND="${RDEPEND}
	test? ( dev-python/pygobject )
	dev-util/pkgconfig"

RESTRICT_PYTHON_ABIS="3*"

src_prepare() {
	# Disable compiling of .pyc files.
	mv "${S}"/py-compile "${S}"/py-compile.orig
	ln -s $(type -P true) "${S}"/py-compile

	python_copy_sources
}

src_configure() {
	configure_package() {
		econf --docdir=/usr/share/doc/dbus-python-${PV}
	}
	python_execute_function -s configure_package
}

src_compile() {
	build_package() {
		emake
	}
	python_execute_function -s build_package
}

src_install() {
	python_need_rebuild

	install_package() {
		emake DESTDIR="${D}" install
	}
	python_execute_function -s install_package

	if use examples; then
		insinto /usr/share/doc/${PF}/
		doins -r examples || die
	fi
}

pkg_postinst() {
	python_mod_optimize dbus
}

pkg_postrm() {
	python_mod_cleanup
}
