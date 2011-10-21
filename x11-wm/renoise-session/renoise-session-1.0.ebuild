# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/evilwm/evilwm-1.0.1.ebuild,v 1.1 2009/09/23 15:37:38 jer Exp $

DESCRIPTION="Tool to add renoise as a desktop session for X."
SRC_URI=""
HOMEPAGE=""

IUSE=""
SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86"

RDEPEND=""
DEPEND="${RDEPEND}"

src_install () {
    exeinto /etc/X11/Session
    doexe "${FILESDIR}/Renoise.sh" || die "Renoise.sh failed."

	insinto /usr/share/xsessions
	doins "${FILESDIR}/Renoise.desktop" || die "Renoise.desktop failed."
}
