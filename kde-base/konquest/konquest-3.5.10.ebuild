# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konquest/konquest-3.5.10.ebuild,v 1.6 2009/07/08 14:30:05 alexxy Exp $
KMNAME=kdegames
EAPI="1"
inherit kde-meta

DESCRIPTION="Galactic Strategy KDE Game"
KEYWORDS="~alpha amd64 hppa ~ia64 ~mips ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"

DEPEND=">=kde-base/libkdegames-${PV}:${SLOT}"
RDEPEND="${DEPEND}"

KMEXTRACTONLY=libkdegames
KMCOPYLIB="libkdegames libkdegames"
