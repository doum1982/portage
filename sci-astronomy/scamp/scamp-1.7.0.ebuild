# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/scamp/scamp-1.7.0.ebuild,v 1.1 2010/05/03 21:44:04 bicatali Exp $

EAPI=2

DESCRIPTION="Computes astrometric and photometric solutions for astronomical images"
HOMEPAGE="http://astromatic.iap.fr/software/scamp"
SRC_URI="ftp://ftp.iap.fr/pub/from_users/bertin/${PN}/${P}.tar.gz"

LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc threads plplot"

RDEPEND=">=sci-astronomy/cdsclient-3.4
	virtual/cblas
	>=sci-libs/lapack-atlas-3.8.0
	sci-libs/fftw:3.0
	plplot? ( >=sci-libs/plplot-5.9 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	# gentoo uses cblas instead of ptcblas (linked to threaded with eselect)
	sed -i \
		-e 's/ptcblas/cblas/g' \
		configure || die "sed failed"
}

src_configure() {
	econf \
		--with-atlas="/usr/$(get_libdir)/lapack/atlas" \
		$(use_with plplot) \
		$(use_enable threads)
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog HISTORY README THANKS BUGS
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins doc/*.pdf || die "pdf doc install failed"
	fi
}
