# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools eutils

DESCRIPTION="OpenGL window and compositing manager"
HOMEPAGE="https://github.com/compiz-reloaded"
SRC_URI="https://github.com/compiz-reloaded/compiz/releases/download/v0.8.12.3/compiz-0.8.12.3.tar.xz"

LICENSE="GPL-2 LGPL-2.1 MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="+cairo dbus fuse gtk2 +gtk3 +svg inotify marco mate gsettings compizconfig"
REQUIRED_USE="gtk2? ( !gtk3 ) marco? ( ^^ ( gtk2 gtk3 ) ) mate? ( ^^ ( gtk2 gtk3 ) ) gsettings? ( ^^ ( gtk2 gtk3 ) )"

COMMONDEPEND="
	>=dev-libs/glib-2
	dev-libs/libxml2
	dev-libs/libxslt
	media-libs/libpng:0=
	>=media-libs/mesa-6.5.1-r1
	>=x11-base/xorg-server-1.1.1-r1
	>=x11-libs/libX11-1.4
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libICE
	x11-libs/libSM
	>=x11-libs/libXrender-0.8.4
	>=x11-libs/startup-notification-0.7
	virtual/glu
	cairo? (
		>=x11-libs/cairo-1.4[X]
	)
	dbus? (
		>=sys-apps/dbus-1.0
		dev-libs/dbus-glib
	)
	fuse? ( sys-fs/fuse )
	gtk2? (
		>=x11-libs/gtk+-2.8.0:2
		>=x11-libs/libwnck-2.18.3:1
		x11-libs/pango
	)
	gtk3? (
		x11-libs/gtk+:3
		x11-libs/libwnck:3
		x11-libs/pango
	)
	svg? (
		>=gnome-base/librsvg-2.14.0:2
		>=x11-libs/cairo-1.4
	)
	marco? (
                x11-wm/marco
        )
        gsettings? (
                >=dev-libs/glib-2.32
        )
        compizconfig? (
                >=compiz-reloaded/libcompizconfig-0.8.12
        )
"

DEPEND="${COMMONDEPEND}
	virtual/pkgconfig
	x11-proto/damageproto
	x11-proto/xineramaproto
"

RDEPEND="${COMMONDEPEND}
	x11-apps/mesa-progs
	x11-apps/xdpyinfo
	x11-apps/xset
	x11-apps/xvinfo
"

DOCS=( AUTHORS ChangeLog NEWS TODO )

src_prepare() {
	echo gtk/gnome/compiz-wm.desktop.in >> po/POTFILES.skip
	echo metadata/core.xml.in >> po/POTFILES.skip

	## gcc 4.7 patch failed on compiz-reloaded... hopefully we don't need it
	# Patch for compatibility with gcc 4.7
	##epatch "${FILESDIR}"/${PN}-gcc-4.7.patch

	eautoreconf
}

src_configure() {
        local myconf=""
        if ( use gtk2 ); then
            myconf+=" --enable-gtk"
            myconf+=" --with-gtk=2.0"
        elif ( use gtk3 ); then
            myconf+=" --enable-gtk"
            myconf+=" --with-gtk=3.0"
        else
            myconf+=" --disable-gtk"
        fi
        
	econf \
		--enable-fast-install \
		--disable-static \
		$(use_enable svg librsvg) \
		$(use_enable cairo annotate) \
		$(use_enable dbus) \
		$(use_enable dbus dbus-glib) \
		$(use_enable fuse) \
		$(use_enable inotify) \
		$(use_enable marco) \
		$(use_enable mate) \
		$(use_enable gsettings) \
		$(use_enable compizconfig) \
		${myconf}
}

src_install() {
	default
	prune_libtool_files --all

## This is outdated and should be either updated, and made optional with a use flag or removed.
#
#	# Install compiz-manager
#	dobin "${FILESDIR}"/compiz-manager
#
#	# Add the full-path to lspci
#	sed -i "s#lspci#/usr/sbin/lspci#" "${D}/usr/bin/compiz-manager" || die
#
#	# Fix the hardcoded lib paths
#	sed -i "s#/lib/#/$(get_libdir)/#g" "${D}/usr/bin/compiz-manager" || die
#
#	# Create gentoo's config file
#	dodir /etc/xdg/compiz
#
#	cat <<- EOF > "${D}/etc/xdg/compiz/compiz-manager"
#	COMPIZ_BIN_PATH="/usr/bin/"
#	PLUGIN_PATH="/usr/$(get_libdir)/compiz/"
#	LIBGL_NVIDIA="/usr/$(get_libdir)/opengl/xorg-x11/lib/libGL.so.1.2"
#	LIBGL_FGLRX="/usr/$(get_libdir)/opengl/xorg-x11/lib/libGL.so.1.2"
#	KWIN="$(type -p kwin)"
#	METACITY="$(type -p metacity)"
#	SKIP_CHECKS="yes"
#	EOF

	domenu "${FILESDIR}"/compiz.desktop
}

pkg_postinst() {
    elog "Do NOT report bugs about this package!"
    elog "This is a homebrewed ebuild and is not" 
    elog "maintained by anyone. In fact, it might" 
    elog "self-destruct at any moment... :)"
}
