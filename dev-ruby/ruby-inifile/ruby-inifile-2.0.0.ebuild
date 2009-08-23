# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-inifile/ruby-inifile-2.0.0.ebuild,v 1.2 2009/08/22 22:31:06 a3li Exp $

inherit ruby

DESCRIPTION="Small library to parse INI-files in Ruby"
HOMEPAGE="http://raa.ruby-lang.org/project/ruby-inifile/"
SRC_URI="http://gregoire.lejeune.free.fr/${PN}_${PV}.tar.gz"

SLOT="0"
IUSE=""
USE_RUBY="ruby18"
LICENSE="Ruby"
KEYWORDS="~x86 ~amd64"
S=${WORKDIR}/${PN}
