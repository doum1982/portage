# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/prosite/prosite-20.36.ebuild,v 1.4 2011/08/09 15:36:16 xarthisius Exp $

DESCRIPTION="A protein families and domains database"
LICENSE="swiss-prot"
HOMEPAGE="http://ca.expasy.org/prosite"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
# Minimal build keeps only the indexed files (if applicable) and the
# documentation. The non-indexed database is not installed.
IUSE="emboss minimal"
KEYWORDS="amd64 ~ppc x86"

DEPEND="emboss? ( sci-biology/emboss )"

RDEPEND="${DEPEND}"

src_compile() {
	if use emboss; then
		mkdir PROSITE
		echo
		einfo "Indexing PROSITE for usage with EMBOSS."
		EMBOSS_DATA="." prosextract -auto -prositedir "${S}" || die \
			"Indexing PROSITE failed."
		echo
	fi
}

src_install() {
	if ! use minimal; then
		insinto /usr/share/${PN}
		doins *.{doc,dat} || die "Installing raw database failed."
	fi
	insinto /usr/share/doc/${PF}
	doins *.pdf || die "PDF documentation installation failed."
	if use emboss; then
		insinto /usr/share/EMBOSS/data/PROSITE
		doins PROSITE/* || die "Installing EMBOSS data files failed."
	fi
}
