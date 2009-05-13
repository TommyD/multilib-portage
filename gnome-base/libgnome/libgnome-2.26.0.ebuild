# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnome/libgnome-2.24.1.ebuild,v 1.3 2009/03/06 15:36:28 ranger Exp $

EAPI="2"

inherit gnome2 multilib-native

DESCRIPTION="Essential Gnome Libraries"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="branding doc esd"

SRC_URI="${SRC_URI}
       branding? ( mirror://gentoo/gentoo-gdm-theme-r3.tar.bz2 )"

RDEPEND=">=gnome-base/gconf-2[lib32?]
	>=dev-libs/glib-2.16[lib32?]
	>=gnome-base/gnome-vfs-2.5.3[lib32?]
	>=gnome-base/libbonobo-2.13[lib32?]
	>=dev-libs/popt-1.7[lib32?]
	esd? (
		>=media-sound/esound-0.2.26
		>=media-libs/audiofile-0.2.3
	)"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	>=dev-util/pkgconfig-0.17
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} --disable-schemas-install $(use_enable esd)"
}

multilib-native_src_prepare_internal() {
	gnome2_src_prepare

	use branding && epatch "${FILESDIR}"/${P}-branding.patch
}

multilib-native_src_install_internal() {
	gnome2_src_install
	
	if use branding; then
		# Add gentoo backgrounds
		dodir /usr/share/pixmaps/backgrounds/gnome/gentoo
		insinto /usr/share/pixmaps/backgrounds/gnome/gentoo
		doins "${WORKDIR}"/gentoo-emergence/gentoo-emergence.png || die "doins 1 failed"
		doins "${WORKDIR}"/gentoo-cow/gentoo-cow-alpha.png || die "doins 2 failed"
	fi
}
