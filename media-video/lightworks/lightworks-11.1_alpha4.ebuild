# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/tribler/tribler-6.0.2.ebuild,v 1.3 2012/12/14 12:53:25 ago Exp $

EAPI="4"

inherit eutils

MY_PV="11.1"

DESCRIPTION="Lightworks is the fastest, most accessible and focused NLE in the industry"
HOMEPAGE="http://www.lwks.com/"
SRC_URI="http://www.lwks.com/dmpub/lwks-11.1.D-amd64.deb"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/glib
	dev-libs/atk
	dev-libs/expat
	dev-libs/libffi
	sys-apps/dbus
	sys-fs/udev
    x11-libs/pango
	x11-libs/gdk-pixbuf
	x11-libs/cairo
	x11-libs/pixman
	x11-libs/gtk+:3
	x11-libs/qt-gui
	x11-libs/qt-core
	virtual/jpeg
	media-libs/libpng
	media-libs/tiff:3
	>=media-libs/freetype-2
	media-libs/fontconfig
	media-libs/mesa
	media-libs/glu
	media-gfx/nvidia-cg-toolkit
	x11-libs/libxcb
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXcursor
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXrender
	x11-libs/libXfixes
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libdrm
	app-accessibility/at-spi2-core
"

DEPEND="${RDEPEND}
    !app-arch/deb2targz
	app-arch/unzip
    x11-apps/mkfontdir"

S="${WORKDIR}"

pkg_setup() {
	:;
}

src_unpack() {
    unpack ${A}
    unpack ./data.tar.gz
    #unpack ./control.tar.gz
}

src_prepare() {
    # Generate a machine number (if there isn't one already)
    if [ ! -f /usr/share/${PN}/machine.num ];
    then
        cat > usr/share/${PN}/machine.num << EOF
        $((`cat /dev/urandom|od -N1 -An -i` % 2500))
EOF
    else
        cat /usr/share/${PN}/machine.num > usr/share/${PN}/machine.num
    fi
}

src_compile() {
    :;
}

src_install() {
    insinto /usr/bin
    doins usr/bin/${PN} || die "doins bin failed"

    insinto /usr/lib/${PN}
    doins -r usr/lib/${PN}/* || die "doins lib failed"

    fperms a+rw "usr/share/lightworks/Preferences"
    fperms a+rw "usr/share/lightworks/Audio Mixes"

    insinto /usr/share/${PN}
    doins -r usr/share/${PN}/* || die "doins share failed"

    insinto /usr/share/applications
    sed -ie "s/11.1.D/${MY_PV}/" usr/share/applications/lightworks.desktop
    doins usr/share/applications/* || die "doins desktop application failed"

    insinto /usr/share/fonts
    doins -r usr/share/fonts/* || die "doins fonts failed"
    mkfontdir ${D}/usr/share/fonts/truetype

    dodoc usr/share/doc/${PN}/*

    #sh postinst
}
