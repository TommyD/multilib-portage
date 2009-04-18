# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXrandr/libXrandr-1.2.3.ebuild,v 1.8 2009/04/16 02:21:24 jer Exp $

# Must be before x-modular eclass is inherited
# SNAPSHOT="yes"

EAPI="2"

inherit x-modular multilib-native

DESCRIPTION="X.Org Xrandr library"

KEYWORDS="~alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 ~s390 sh sparc x86 ~x86-fbsd"

RDEPEND="x11-libs/libX11[lib32?]
	x11-libs/libXext[lib32?]
	x11-libs/libXrender[lib32?]
	>=x11-proto/randrproto-1.2
	x11-proto/xproto"
DEPEND="${RDEPEND}
	x11-proto/renderproto"
