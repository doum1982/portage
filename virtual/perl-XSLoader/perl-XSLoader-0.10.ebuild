# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-XSLoader/perl-XSLoader-0.10.ebuild,v 1.5 2010/11/18 10:58:46 maekke Exp $

DESCRIPTION="Virtual for XSLoader"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~ppc-macos"
IUSE=""

RDEPEND="|| ( ~dev-lang/perl-5.12.2 ~dev-lang/perl-5.12.1 ~dev-lang/perl-5.10.1 ~perl-core/XSLoader-${PV} )"
