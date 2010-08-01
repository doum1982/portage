# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gstreamer/ruby-gstreamer-0.19.4.ebuild,v 1.3 2010/08/01 09:52:20 hwoarang Exp $

EAPI="2"
USE_RUBY="ruby18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby GStreamer bindings"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="${RDEPEND}
	=media-libs/gstreamer-0.10*
	=media-libs/gst-plugins-base-0.10*"
DEPEND="${DEPEND}
	=media-libs/gstreamer-0.10*
	=media-libs/gst-plugins-base-0.10*
	dev-util/pkgconfig"
