# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/hsql-sqlite/hsql-sqlite-1.8.1.ebuild,v 1.1 2011/08/04 12:44:55 slyfox Exp $

# ebuild generated by hackport 0.2.13

EAPI="3"

CABAL_FEATURES="lib profile haddock hscolour"
inherit haskell-cabal

MY_PN=hsql-sqlite3
MY_P=${MY_PN}-${PV}

DESCRIPTION="SQLite3 driver for HSQL."
HOMEPAGE="http://hackage.haskell.org/package/hsql-sqlite3"
SRC_URI="http://hackage.haskell.org/packages/archive/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-haskell/hsql-1.8
		>=dev-lang/ghc-6.10.1
		>=dev-db/sqlite-3.0"

DEPEND="${RDEPEND}
		dev-haskell/cabal"

S="${WORKDIR}/${MY_P}"
