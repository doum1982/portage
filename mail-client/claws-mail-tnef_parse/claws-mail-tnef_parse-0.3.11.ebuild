# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/claws-mail-tnef_parse/claws-mail-tnef_parse-0.3.11.ebuild,v 1.1 2011/08/30 11:05:01 fauli Exp $

EAPI=4

inherit multilib

MY_P="${P#claws-mail-}"

DESCRIPTION="Plugin for Claws to support application/ms-tnef attachments"
HOMEPAGE="http://www.claws-mail.org/"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RDEPEND=">=mail-client/claws-mail-3.7.10"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README

	# kill useless files
	rm -f "${D}"/usr/$(get_libdir)/claws-mail/plugins/*.{a,la}
}
