# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/suse-build/suse-build-9999.ebuild,v 1.2 2011/08/15 09:04:56 miska Exp $

EAPI=4

EGIT_REPO_URI="git://gitorious.org/opensuse/build.git"
[[ "${PV}" == "9999" ]] && EXTRA_ECLASS="git-2"
MY_PN="build"

inherit eutils ${EXTRA_ECLASS}

DESCRIPTION="Script to build SUSE Linux RPMs"
HOMEPAGE="https://build.opensuse.org/package/show?package=build&project=openSUSE%3ATools"
[[ "${PV}" == "9999" ]] || SRC_URI="https://api.opensuse.org/public/source/openSUSE:11.4/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
[[ "${PV}" == "9999" ]] || KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/perl-Digest-MD5
	virtual/perl-Getopt-Long
	dev-perl/XML-Parser
	dev-perl/TimeDate
	app-shells/bash
	app-arch/rpm"

S="${WORKDIR}/${MY_PN}-${PV}"

src_compile() { :; }

src_install() {
	emake DESTDIR="${D}" pkglibdir=/usr/share/suse-build install
	cd "${ED}"/usr
	find bin -type l | while read i; do
		mv "${i}" "${i/bin\//bin/suse-}"
	done
	find share/man/man1 -type f | while read i; do
		mv "${i}" "${i/man1\//man1/suse-}"
	done
	find . -type f -exec grep -l "/usr/lib/build" \{\} \; | while read i; do
		sed -i 's|/usr/lib/build|/usr/share/suse-build|' "${i}"
	done
}
