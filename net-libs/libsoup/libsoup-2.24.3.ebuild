# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libsoup/libsoup-2.24.3.ebuild,v 1.7 2009/03/18 14:28:53 armin76 Exp $

EAPI="2"

inherit gnome2 multilib-native

DESCRIPTION="An HTTP library implementation in C"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="2.4"
KEYWORDS="alpha amd64 ~arm ~hppa ia64 ~mips ppc ppc64 ~sh ~sparc x86 ~x86-fbsd"
# Do NOT build with --disable-debug/--enable-debug=no - gnome2.eclass takes care of that
IUSE="debug doc ssl"

RDEPEND=">=dev-libs/glib-2.15.3
		 >=dev-libs/libxml2-2
		 ssl? ( >=net-libs/gnutls-1 )"
DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.9
		doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"

multilib-native_pkg_setup_internal() {
	G2CONF="${G2CONF} $(use_enable ssl) --disable-static"
}