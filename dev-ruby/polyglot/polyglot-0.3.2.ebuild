# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/polyglot/polyglot-0.3.2.ebuild,v 1.2 2011/07/31 16:36:21 armin76 Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 jruby ree18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_EXTRADOC="History.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="Polyglot provides support for fully-custom DSLs."
HOMEPAGE="http://polyglot.rubyforge.org/"
LICENSE="MIT"

KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-solaris"
SLOT="0"
IUSE=""
