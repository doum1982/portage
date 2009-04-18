# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virtinst/virtinst-0.400.3.ebuild,v 1.1 2009/04/17 16:22:29 cardoe Exp $

inherit distutils eutils

DESCRIPTION="Python modules for starting virtualized guest installations"
HOMEPAGE="http://virt-manager.et.redhat.com/"
SRC_URI="http://virt-manager.et.redhat.com/download/sources/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND=">=app-emulation/libvirt-0.2.1
	dev-python/urlgrabber"
DEPEND="${RDEPEND}"
