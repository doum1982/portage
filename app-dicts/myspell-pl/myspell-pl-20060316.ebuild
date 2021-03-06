# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-pl/myspell-pl-20060316.ebuild,v 1.17 2010/09/27 23:40:28 leio Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"pl,PL,pl_PL,Polish (Poland),pl_PL.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"pl,PL,hyph_pl_PL,Polish (Poland),hyph_pl_PL.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
"pl,PL,th_pl_PL,Polish (Poland),thes_pl_PL.zip"
)

inherit myspell

DESCRIPTION="Polish dictionaries for myspell/hunspell"
LICENSE="CCPL-ShareAlike-1.0 LGPL-2.1 GPL-2"
HOMEPAGE="http://lingucomponent.openoffice.org/ http://www.kurnik.pl/dictionary/ http://synonimy.sourceforge.net/"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd"
