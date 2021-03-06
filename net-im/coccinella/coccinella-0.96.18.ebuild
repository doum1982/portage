# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/coccinella/coccinella-0.96.18.ebuild,v 1.3 2010/05/18 15:22:37 mr_bones_ Exp $

inherit eutils fdo-mime

NAME=Coccinella
DESCRIPTION="Jabber Client With a Built-in Whiteboard and VoIP (jingle)"
HOMEPAGE="http://www.thecoccinella.org/"
SRC_URI="mirror://sourceforge/coccinella/${NAME}-${PV}Src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="ssl"

DEPEND=">=dev-lang/tk-8.5
	>=dev-tcltk/tkpng-0.9
	>=dev-tcltk/tktreectrl-2.2.9
	>=dev-tcltk/tktray-1.1
	>=dev-tcltk/snack-2.2
	ssl? ( >=dev-tcltk/tls-1.4 )
	>=dev-tcltk/tkimg-1.3"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${NAME}-${PV}Src"

src_unpack() {
	unpack ${A}
}

src_compile() {
	einfo "Nothing to compile for ${P}."
}

src_install () {
	rm -R "${S}"/bin/unix/Linux/i686/treectrl
	rm -R "${S}"/bin/unix/Linux/i686/tkpng
	rm -R "${S}"/bin/unix/Linux/i686/tktray
	rm -R "${S}"/bin/unix/Linux/i686/snack2.2
	rm -R "${S}"/bin/unix/Linux/i686/tls1.4
	rm -R "${S}"/bin/unix/Linux/i686/Img1.3
	rm -R "${S}"/bin/macosx
	rm -R "${S}"/bin/windows
	rm -R "${S}"/bin/unix/NetBSD

	dodir /opt/coccinella
	cp -R "${S}"/* ${D}/opt/coccinella/
	fperms 0755 /opt/coccinella/Coccinella.tcl
	dosym /opt/coccinella/Coccinella.tcl /opt/bin/coccinella
	dodoc README.txt READMEs/*

	for x in 128 64 32 16 ; do
		src=/opt/coccinella/themes/Oxygen/icons/${x}x${x}/coccinella.png
		src2=/opt/coccinella/themes/Oxygen/icons/${x}x${x}/coccinella.png
		src2shadow=/opt/coccinella/themes/Oxygen/icons/${x}x${x}/coccinella2-shadow.png
		dir=/usr/share/icons/hicolor/${x}x${x}/apps
		dodir ${dir}
		dosym ${src} ${dir}/coccinella.png
		dosym ${src2} ${dir}/coccinella2.png
		dosym ${src2shadow} ${dir}/coccinella2-shadow.png
		unset src
		unset src2
		unset src2shadow
		unset dir
	done

        make_desktop_entry "coccinella" "Coccinella IM Client" "coccinella2-shadow"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
