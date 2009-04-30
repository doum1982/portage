# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/aws-s3/aws-s3-0.6.2.ebuild,v 1.1 2009/04/29 18:12:12 flameeyes Exp $

inherit ruby

DESCRIPTION="Client library for Amazon's Simple Storage Service's REST API"
HOMEPAGE="http://amazon.rubyforge.org/"
SRC_URI="mirror://rubyforge/amazon/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test"

RDEPEND="dev-ruby/xml-simple
	dev-ruby/builder
	dev-ruby/mime-types"
DEPEND="${RDEPEND}
	test? ( dev-ruby/ruby-debug
		dev-ruby/flexmock )
	dev-ruby/rake"

USE_RUBY="ruby18"

src_unpack() {
	unpack ${A}

	# Remove extra files generated by Mac OS X during packaging
	find "${S}" -name '._*' -delete

	# As of release 0.6.2 this part is going to break when building
	# with Ruby 1.9; we disable it since we don't need it at all.
	sed -i -e '/^namespace :site/,/^end/ d' "${S}"/Rakefile \
		|| die "sed out of rake's :site namespace failed"
}

src_compile() {
	if use doc; then
		rake doc:rerdoc || die "rake rerdoc failed"
	fi
}

src_test() {
	for ruby in $USE_RUBY; do
		[[ -n `type -p $ruby` ]] && $ruby $(type -p rake) test || die "testsuite failed"
	done
}

src_install() {
	pushd lib
	doruby -r * || die "doruby failed"
	popd

	dobin bin/s3sh || die "dobin failed"

	if use doc; then
		dohtml -r doc/* || die "dohtml failed"
	fi

	dodoc README || die "dodoc failed"

	insinto $(${RUBY} -r rbconfig -e 'print Config::CONFIG["sitedir"]')/../gems/1.8/specifications
	sed -e "s:@VERSION@:${PV}:" "${FILESDIR}"/${PN}.gemspec > "${T}"/${P}.gemspec
	doins "${T}"/${P}.gemspec || die "Unable to install fake gemspec"
}
