# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/folding/folding-2009.0905.0811.ebuild,v 1.1 2009/10/16 20:43:35 ulm Exp $

inherit elisp

DESCRIPTION="A folding-editor-like Emacs minor mode"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/FoldingMode"
# taken from http://git.savannah.gnu.org/cgit/emacs-tiny-tools.git
SRC_URI="mirror://gentoo/${P}.el.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~x86"
IUSE=""

SITEFILE="70${PN}-gentoo.el"
