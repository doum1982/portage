# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-vienna/embassy-vienna-1.7.2.ebuild,v 1.3 2011/03/13 13:00:33 armin76 Exp $

EBOV="6.0.1"

inherit embassy

DESCRIPTION="EMBOSS integrated version of the Vienna RNA package - RNA folding"
SRC_URI="ftp://emboss.open-bio.org/pub/EMBOSS/EMBOSS-${EBOV}.tar.gz
	mirror://gentoo/embassy-${EBOV}-${PN:8}-${PV}.tar.gz"

KEYWORDS="amd64 ~ppc x86"
