# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/oldstandard/oldstandard-2.0.2.ebuild,v 1.3 2011/05/25 16:37:22 flameeyes Exp $

inherit font

DESCRIPTION="Old Standard - font with wide range of Latin, Greek and Cyrillic characters"
HOMEPAGE="http://www.thessalonica.org.ru/en/fonts.html"
SRC_URI="http://www.thessalonica.org.ru/downloads/${P}.otf.zip
		http://www.thessalonica.org.ru/downloads/${P}.ttf.zip"

LICENSE="OFL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}
FONT_S=${S}
FONT_SUFFIX="otf ttf"
DOCS="OFL.txt OFL-FAQ.txt FONTLOG.txt"
