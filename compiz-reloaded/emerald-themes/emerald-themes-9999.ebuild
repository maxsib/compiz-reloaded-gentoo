# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="4"

inherit git-r3 autotools

DESCRIPTION="Emerald window decorator themes"
HOMEPAGE="http://compiz.org"
##SRC_URI="http://cgit.compiz.org/fusion/decorators/${PV}/snapshot/${P}.tar.bz2"
EGIT_REPO_URI="git://github.com/compiz-reloaded/emerald-themes.git"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""
DEPEND=">=compiz-reloaded/emerald-${PV}"

DOCS="INSTALL NEWS"

src_prepare(){
    eautoreconf
}

pkg_postinst() {
    elog "Do NOT report bugs about this package!"
    elog "This is a homebrewed ebuild and is not" 
    elog "maintained by anyone. In fact, it might" 
    elog "self-destruct at any moment... :)"
}
