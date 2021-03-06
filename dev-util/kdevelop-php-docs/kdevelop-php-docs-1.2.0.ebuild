# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevelop-php-docs/kdevelop-php-docs-1.2.0.ebuild,v 1.2 2011/04/12 22:20:18 dilfridge Exp $

EAPI=4

KDE_LINGUAS="ca ca@valencia da de en_GB es et fr gl it nb nds nl pt pt_BR ru sv uk zh_CN zh_TW"

KMNAME="kdevelop"
KMMODULE="php-docs"
KDEVELOP_VERSION="4.2.0"
inherit kde4-base

DESCRIPTION="PHP documentation plugin for KDevelop 4"

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2 LGPL-2"
IUSE="debug"
