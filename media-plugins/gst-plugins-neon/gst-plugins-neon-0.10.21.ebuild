# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-neon/gst-plugins-neon-0.10.21.ebuild,v 1.4 2011/07/25 18:07:10 xarthisius Exp $

inherit gst-plugins-bad

KEYWORDS="~alpha amd64 ppc ppc64 x86"
IUSE=""

RDEPEND=">=net-libs/neon-0.27
	>=media-libs/gst-plugins-base-0.10.32"
DEPEND="${RDEPEND}"
