# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-gconf/gnome2-gconf-1.044.ebuild,v 1.2 2010/07/20 16:36:09 jer Exp $

inherit perl-module

MY_P=Gnome2-GConf-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Perl wrappers for the GConf configuration engine."
SRC_URI="mirror://cpan/authors/id/T/TS/TSCH/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=gnome-base/gconf-2
	>=dev-perl/glib-perl-1.120
	dev-lang/perl"
DEPEND="${RDEPEND}
	>=dev-perl/extutils-pkgconfig-1.03
	>=dev-perl/extutils-depends-0.202
	dev-util/pkgconfig"
SRC_TEST=do
