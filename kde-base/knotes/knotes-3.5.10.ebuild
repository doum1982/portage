# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/knotes/knotes-3.5.10.ebuild,v 1.6 2009/07/08 14:25:21 alexxy Exp $

KMNAME=kdepim
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE Notes"
KEYWORDS="~alpha amd64 hppa ~ia64 ~mips ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=kde-base/libkcal-${PV}:${SLOT}
>=kde-base/libkdepim-${PV}:${SLOT}
>=kde-base/kontact-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMCOPYLIB="
	libkcal libkcal
	libkdepim libkdepim
	libkpinterfaces kontact/interfaces"
KMEXTRACTONLY="
	libkcal/
	libkdepim/
	kontact/interfaces"
KMEXTRA="kontact/plugins/knotes" # We add here the kontact's plugin instead of compiling it with kontact because it needs a lot of this programs deps.
