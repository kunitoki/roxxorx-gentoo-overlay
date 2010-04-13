# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit nsplugins

DESCRIPTION="VRML/X3D 3D player"
HOMEPAGE="http://www.octaga.com/"
MY_P="${PN}.${PV}"
MY_PV="${PV}"
SRC_URI="http://www.octaga.com/freedownloads/OctagaPlayer/linux/${MY_PV}/${MY_P}.tar.gz"
LICENSE="octagaplayer"
SLOT="0"
KEYWORDS="~x86"
IUSE="nsplugin"
DEPEND=""
RDEPEND=">=x11-libs/gtk+-2
         media-libs/openal"
RESTRICT="strip"


pkg_setup() {
	has_multilib_profile && ABI="x86"
}

src_unpack() {
	unpack ${A}
}

src_install() {
	dodir /usr/share/octagaplayer
	cp -pPR ${WORKDIR}/${MY_P}/usr/share/octagaplayer ${D}/usr/share/

	dodir /usr/lib/octagaplayer
	cp -pPR ${WORKDIR}/${MY_P}/usr/lib/octagaplayer ${D}/usr/lib/

	dobin ${WORKDIR}/${MY_P}/usr/bin/octagaplayer

	if use nsplugin ; then
		cd ${WORKDIR}/${MY_P}/usr/lib/mozilla/plugins
		insinto /opt/netscape/plugins
		doins npOctaga.so

        inst_plugin /opt/netscape/plugins/npOctaga.so
	fi
}

pkg_postinst() {
	ewarn
	ewarn The application seg faults too often.
	if use nsplugin ; then
		ewarn
		ewarn The Netscape plugin is unstable and can only run on GTK+ based browsers
		ewarn like Mozilla and Firefox. If you want VRML/X3D support in Konqueror
		ewarn install freewrl nsplugin instead.
	fi
	ewarn
}
