# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdcss/libdvdcss-1.2.10.ebuild,v 1.1 2008/08/29 21:50:30 aballier Exp $

inherit eutils autotools multilib-native

DESCRIPTION="A portable abstraction library for DVD decryption"
HOMEPAGE="http://www.videolan.org/developers/libdvdcss.html"
SRC_URI="http://www.videolan.org/pub/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="1.2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e 's:noinst_PROGRAMS:check_PROGRAMS:' \
		"${S}"/test/Makefile.am \
		|| die "unable to disable tests building"

	eautoreconf
}

multilib-native_src_compile_internal() {
	# See bug #98854, requires access to fonts cache for TeX
	# No need to use addwrite, just set TeX font cache in the sandbox
	use doc && export VARTEXFONTS="${T}/fonts"

	econf \
		--enable-static --enable-shared \
		$(use_enable doc) \
		--disable-dependency-tracking || die
	emake || die
}

multilib-native_src_install_internal() {
	emake install DESTDIR="${D}" || die

	dodoc AUTHORS ChangeLog NEWS README
	use doc && dohtml doc/html/*
	use doc && dodoc doc/latex/refman.ps
}