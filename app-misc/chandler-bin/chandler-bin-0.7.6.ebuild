# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-sendto/nautilus-sendto-0.8.ebuild,v 1.3 2006/12/07 04:24:49 compnerd Exp $

inherit eutils autotools

DESCRIPTION="A notebook you can organize, back up and share!"
HOMEPAGE="http://chandlerproject.org/"
SRC_URI="http://downloads.osafoundation.org/chandler/releases/latest/Chandler_linux_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

BASE="/opt"
MY_P="Chandler_linux_${PV}"
DS_P="chandler-${PV}"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack "${A}"
}

#src_compile() {
#    null
#}

src_install() {

    dodir ${BASE}
    dodir ${BASE}/${DS_P}
    cp -R ${S}/* "${D}"/${BASE}/${DS_P}

    dodir /usr/bin
    dosym ${BASE}/${DS_P}/chandler "${D}"/usr/bin/chandler

    dodir /etc/env.d
    echo "CHANDLERHOME=${BASE}/${DS_P}" >> "${D}"/etc/env.d/50chandler-bin
}
