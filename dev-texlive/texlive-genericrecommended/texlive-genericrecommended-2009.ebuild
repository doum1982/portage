# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-genericrecommended/texlive-genericrecommended-2009.ebuild,v 1.3 2010/10/02 19:54:01 grobian Exp $

TEXLIVE_MODULE_CONTENTS="epsf fontname genmisc multido tex-ps collection-genericrecommended
"
TEXLIVE_MODULE_DOC_CONTENTS="epsf.doc fontname.doc multido.doc tex-ps.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Recommended generic packages"

LICENSE="GPL-2 GPL-1 LPPL-1.3 public-domain "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2009
!=dev-texlive/texlive-basic-2007*
!<dev-texlive/texlive-texinfo-2009
"
RDEPEND="${DEPEND} "
