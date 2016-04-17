# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="4"

inherit autotools

DESCRIPTION="Compiz Fusion Window Decorator Experimental Plugins"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="https://github.com/compiz-reloaded/compiz-plugins-experimental/releases/download/v${PV}/compiz-plugins-experimental-${PV}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="
	>=gnome-base/librsvg-2.14.0:2
	virtual/jpeg:0
	>=compiz-reloaded/compiz-bcop-0.8.12
	>=compiz-reloaded/compiz-plugins-main-0.8.12
	>=compiz-reloaded/compiz-0.8.12
"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	virtual/pkgconfig
	>=sys-devel/gettext-0.15
	x11-libs/cairo
"

#RESTRICT="mirror"

DOCS="AUTHORS INSTALL NEWS"

src_prepare(){
    eautoreconf
}

pkg_postinst() {
    elog "Do NOT report bugs about this package!"
    elog "This is a homebrewed ebuild and is not" 
    elog "maintained by anyone. In fact, it might" 
    elog "self-destruct at any moment... :)"
}
