# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/activesupport/activesupport-2.3.5-r1.ebuild,v 1.4 2010/05/23 10:36:02 a3li Exp $

EAPI=2
USE_RUBY="ruby18 ree18 jruby"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="CHANGELOG README"

inherit ruby-fakegem

DESCRIPTION="Utility Classes and Extension to the Standard Library"
HOMEPAGE="http://rubyforge.org/projects/activesupport/"

LICENSE="MIT"
SLOT="2.3"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

ruby_add_rdepend ">=dev-ruby/builder-2.1.2 >=dev-ruby/tzinfo-0.3.12"

all_ruby_prepare() {
	# Remove the bundled packages!
	rm -r lib/active_support/vendor/{tzinfo,builder}-* \
		|| die "failed to remove vendor packages"
}
