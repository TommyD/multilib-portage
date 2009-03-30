# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/alsa-plugins/alsa-plugins-1.0.19.ebuild,v 1.4 2009/01/29 17:45:11 lack Exp $

EAPI=2

MY_P="${P/_/}"

inherit autotools flag-o-matic multilib-native

DESCRIPTION="ALSA extra plugins"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/plugins/${MY_P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="debug ffmpeg jack libsamplerate pulseaudio speex"

RDEPEND=">=media-libs/alsa-lib-${PV}
	ffmpeg? ( media-video/ffmpeg
		media-libs/alsa-lib[alsa_pcm_plugins_rate] )
	jack? ( >=media-sound/jack-audio-connection-kit-0.98[lib32?] )
	libsamplerate? (
		media-libs/libsamplerate[lib32?]
		media-libs/alsa-lib[alsa_pcm_plugins_rate] )
	pulseaudio? ( media-sound/pulseaudio )
	speex? ( media-libs/speex[lib32?]
		media-libs/alsa-lib[alsa_pcm_plugins_rate] )
	!media-plugins/alsa-jack"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# For some reasons the polyp/pulse plugin does fail with alsaplayer with a
	# failed assert. As the code works just fine with asserts disabled, for now
	# disable them waiting for a better solution.
	sed -i -e '/AM_CFLAGS/s:-Wall:-DNDEBUG -Wall:' \
		"${S}/pulse/Makefile.am"

	# Bug #256119
	epatch "${FILESDIR}/${P}-missing-avutil.patch"

	eautoreconf
}

multilib-native_src_configure_internal() {
	use debug || append-flags -DNDEBUG

	econf \
		$(use_enable ffmpeg avcodec) \
		$(use_enable jack) \
		$(use_enable libsamplerate samplerate) \
		$(use_enable pulseaudio) \
		$(use_with speex speex lib) \
		--disable-dependency-tracking \
		|| die "econf failed"
}

multilib-native_src_install_internal() {
	emake DESTDIR="${D}" install

	cd "${S}/doc"
	dodoc upmix.txt vdownmix.txt README-pcm-oss
	use jack && dodoc README-jack
	use libsamplerate && dodoc samplerate.txt
	use pulseaudio && dodoc README-pulse
	use ffmpeg && dodoc lavcrate.txt a52.txt
}