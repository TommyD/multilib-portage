# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/c-ares/c-ares-1.4.0.ebuild,v 1.11 2008/03/06 03:48:15 wolf31o2 Exp $

EAPI="2"

inherit multilib-native

DESCRIPTION="C library that resolves names asynchronously"
HOMEPAGE="http://daniel.haxx.se/projects/c-ares/"
SRC_URI="http://daniel.haxx.se/projects/c-ares/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="lib32"

DEPEND=""

multilib-native_src_configure_internal() {
	econf --enable-shared || die
}

multilib-native_src_install_internal() {
	make DESTDIR="${D}" install || die
	dodoc CHANGES NEWS README*
}