# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SMTP-SSL/Net-SMTP-SSL-1.10.0.ebuild,v 1.1 2011/08/29 11:36:56 tove Exp $

EAPI=4

MODULE_AUTHOR=CWEST
MODULE_VERSION=1.01
inherit perl-module

DESCRIPTION="SSL support for Net::SMTP"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="virtual/perl-libnet
	dev-perl/IO-Socket-SSL"
DEPEND="${RDEPEND}"

SRC_TEST="do"
