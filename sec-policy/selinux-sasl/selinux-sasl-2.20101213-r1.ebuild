# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-sasl/selinux-sasl-2.20101213-r1.ebuild,v 1.2 2011/06/02 12:54:44 blueness Exp $

MODS="sasl"
IUSE=""

inherit selinux-policy-2

DESCRIPTION="SELinux policy for sasl"

KEYWORDS="amd64 x86"

POLICY_PATCH="${FILESDIR}/fix-services-sasl-r1.patch"
