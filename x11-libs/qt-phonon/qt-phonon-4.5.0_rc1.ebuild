# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/qt-phonon/qt-phonon-4.5.0_rc1.ebuild,v 1.1 2009/02/11 23:17:55 yngwin Exp $

EAPI="2"
inherit qt4-build multilib-native

DESCRIPTION="The Phonon module for the Qt toolkit"
LICENSE="|| ( GPL-3 GPL-2 )"
SLOT="4"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="+dbus"

DEPEND="~x11-libs/qt-gui-${PV}[debug=,glib,qt3support,lib32?]
	!kde-base/phonon-kde
	!kde-base/phonon-xine
	!media-sound/phonon
	media-libs/gstreamer[lib32?]
	media-libs/gst-plugins-base[lib32?]
	dbus? ( =x11-libs/qt-dbus-${PV}[debug=,lib32?] )"
RDEPEND="${DEPEND}"

QT4_TARGET_DIRECTORIES="
src/phonon
src/plugins/phonon"
QT4_EXTRACT_DIRECTORIES="${QT4_TARGET_DIRECTORIES}
include/
src"

QCONFIG_ADD="phonon"
QCONFIG_DEFINE="QT_GSTREAMER"

multilib-native_src_configure_internal() {
	myconf="${myconf} -phonon -no-opengl -no-svg
		$(qt_use dbus qdbus)"

	qt4-build_src_configure
}