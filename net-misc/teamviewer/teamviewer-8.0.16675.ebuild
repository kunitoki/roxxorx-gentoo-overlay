# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="the All-In-One Solution for Remote Access and Support over the Internet"
HOMEPAGE="http://www.teamviewer.com"


SRC_URI="
        x86?    ( http://www.teamviewer.com/download/version_8x/teamviewer_linux.deb )
        amd64?  ( http://www.teamviewer.com/download/version_8x/teamviewer_linux_x64.deb )
"

LICENSE="TeamViewer"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="mirror strip"

RDEPEND="
        app-emulation/wine
"


src_unpack() {
        unpack ${A}
        unpack ./data.tar.gz
        rm -f control.tar.gz data.tar.gz debian-binary
}


pkg_setup() {
        elog "This ebuild installs the TeamViewer binary and libraries and relies on"
        elog "Gentoo's wine package to run the actual program."
        elog
        elog "If you encounter any problems, consider running TeamViewer with the"
        elog "bundled wine package manually."
}

src_install() {
        insinto /opt/teamviewer/
        doins opt/teamviewer8/tv_bin/wine/drive_c/TeamViewer/*

        insinto /usr/sbin
        doins opt/teamviewer8/tv_bin/teamviewerd
        fperms +x /usr/sbin/teamviewerd

        echo "#!/bin/bash" > teamviewer || die
        echo "export WINEDLLPATH=/opt/teamviewer" >> teamviewer || die
        echo "/usr/bin/wine /opt/teamviewer/TeamViewer.exe" >> teamviewer || die
        insinto /usr/bin
        dobin teamviewer

        dodoc opt/teamviewer8/linux_FAQ_{EN,DE}.txt  || die
        dodoc opt/teamviewer8/CopyRights_{EN,DE}.txt || die

        make_desktop_entry ${PN} TeamViewer ${PN}

        newinitd "${FILESDIR}/teamviewerd.rc" teamviewer
}

pkg_postinst() {
        einfo "In order to properly work, ${PN} now needs a background dameon to be running."
        einfo "An rc script has been installed at /etc/init.d/${PN}"
}
