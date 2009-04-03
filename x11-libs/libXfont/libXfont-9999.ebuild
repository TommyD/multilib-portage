# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=1

inherit x-modular flag-o-matic

DESCRIPTION="X.Org Xfont library"

KEYWORDS=""
IUSE="ipv6"

RDEPEND="x11-libs/xtrans[lib32?]
	x11-libs/libfontenc[lib32?]
	x11-proto/xproto
	x11-proto/fontsproto
	>=media-libs/freetype-2[lib32?]"
DEPEND="${RDEPEND}
	x11-proto/fontcacheproto"

CONFIGURE_OPTIONS="$(use_enable ipv6)
	--with-encodingsdir=/usr/share/fonts/encodings"

pkg_setup() {
	# No such function yet
	# x-modular_pkg_setup

	# (#125465) Broken with Bdirect support
	filter-flags -Wl,-Bdirect
	filter-ldflags -Bdirect
	filter-ldflags -Wl,-Bdirect
}