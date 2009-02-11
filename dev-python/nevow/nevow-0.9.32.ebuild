# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nevow/nevow-0.9.32.ebuild,v 1.2 2009/02/11 08:50:39 lordvan Exp $

NEED_PYTHON="2.4"

inherit twisted distutils multilib

MY_P="Nevow-${PV}"

DESCRIPTION="A web templating framework that provides LivePage, an automatic AJAX toolkit."
HOMEPAGE="http://divmod.org/trac/wiki/DivmodNevow"
SRC_URI="http://divmod.org/trac/attachment/wiki/SoftwareReleases/${MY_P}.tar.gz?format=raw -> ${MY_P}.tar.gz"
#SRC_URI="mirror://gentoo/${MY_P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="doc"
EAPI="2"

RDEPEND=">=dev-python/twisted-2.5
	>=dev-python/twisted-web-8.1.0"
DEPEND="${RDEPEND}
	doc? ( dev-python/docutils )"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="nevow formless"

src_compile() {
	distutils_src_compile
	if use doc; then
		cd doc
		"${python}" make.py || die "documentation building failed"
	fi
}

src_install() {
	export PORTAGE_PLUGINCACHE_NOOP=1
	distutils_src_install
	# mantisia expects js to be under site-packages/
	# but setup.py doesn't install it
	python_version
	insinto /usr/$(get_libdir)/python${PYVER}/site-packages/${PN}
	doins ${PN}/*.js || die "doins failed"
	doins -r ${PN}/js || die "doins failed"
	if use doc; then
		insinto /usr/share/doc/${PF}/
		doins -r doc/txt doc/html examples
	fi
	unset PORTAGE_PLUGINCACHE_NOOP
}

src_test() {
	PYTHONPATH="." trial nevow || die "nevow trial failed"
	PYTHONPATH="." trial formless || die "formless trial failed"
}

pkg_postrm() {
	twisted_pkg_postrm
}

pkg_postinst() {
	twisted_pkg_postinst
}
