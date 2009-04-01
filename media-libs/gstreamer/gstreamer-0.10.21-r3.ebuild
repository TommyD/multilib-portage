# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gstreamer/gstreamer-0.10.21-r3.ebuild,v 1.1 2009/01/09 12:54:19 loki_val Exp $

EAPI=2

inherit autotools eutils multilib versionator multilib-native
#inherit libtool versionator

# Create a major/minor combo for our SLOT and executables suffix
PV_MAJ_MIN=$(get_version_component_range '1-2')

DESCRIPTION="Streaming media framework"
HOMEPAGE="http://gstreamer.sourceforge.net"
SRC_URI="http://${PN}.freedesktop.org/src/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT=${PV_MAJ_MIN}
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="debug nls test"

RDEPEND=">=dev-libs/glib-2.12:2[lib32?]
	dev-libs/libxml2[lib32?]
	>=dev-libs/check-0.9.2[lib32?]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	# Needed for sane .so versioning on Gentoo/FreeBSD
	#elibtoolize
	epatch "${FILESDIR}"/${P}-gtkdoc.patch \
		"${FILESDIR}"/${P}-bison241.patch \
		"${FILESDIR}"/${P}-b.g.o-555631.patch
	AT_M4DIR="common/m4" eautoreconf
}

multilib-native_src_configure_internal() {
	# Disable static archives, dependency tracking and examples
	# to speed up build time
	econf \
		--disable-static \
		--disable-dependency-tracking \
		$(use_enable nls) \
		$(use_enable debug) \
		--disable-valgrind \
		--disable-examples \
		$(use_enable test tests) \
		--with-package-name="GStreamer ebuild for Gentoo" \
		--with-package-origin="http://packages.gentoo.org/package/media-libs/gstreamer"
}

multilib-native_src_install_internal() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS MAINTAINERS README RELEASE

	# Remove unversioned binaries to allow SLOT installations in future
	cd "${D}"/usr/bin
	local gst_bins
	for gst_bins in $(ls *-${PV_MAJ_MIN}); do
		rm ${gst_bins/-${PV_MAJ_MIN}/}
	done
}
