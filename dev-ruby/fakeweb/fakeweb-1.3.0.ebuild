# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fakeweb/fakeweb-1.3.0.ebuild,v 1.3 2011/08/07 18:01:33 armin76 Exp $

EAPI=2

USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_DOCDIR="html"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Helper for faking web requests in Ruby"
HOMEPAGE="http://github.com/chrisk/fakeweb"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

ruby_add_bdepend "
	test? (
		>=dev-ruby/mocha-0.9.5
		virtual/ruby-test-unit
		!dev-ruby/test-unit:2
		dev-ruby/samuel
		dev-ruby/right_http_connection
	)"

all_ruby_prepare() {
	# The package bundles samuel and right_http_connection, remove
	# them and use the packages instead.
	rm -r test/vendor || die "failed to remove bundled gems"

	# We don't package sdoc and we don't have the direct template.
	sed -i -e 's/sdoc/rdoc/' -e '/template/d' Rakefile || die
}
