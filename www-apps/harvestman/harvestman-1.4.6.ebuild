# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/httping/httping-1.2.5.ebuild,v 1.1 2008/01/27 19:11:27 cedk Exp $

inherit eutils

DESCRIPTION="HarvestMan is a web crawler application written in the Python programming language"
HOMEPAGE="http://www.harvestmanontheweb.com/"
SRC_URI="http://download.berlios.de/harvestman/HarvestMan-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="dev-lang/python"
RDEPEND="${DEPEND}"

S="${WORKDIR}/HarvestMan-${PV}"

src_compile() {
    true
#	emake || die "emake failed"
}

src_install() {
    true   
#    dodir /etc
#    cp ${S}/${PN}.conf "${D}"/etc/
#    cp ${S}/${PN}d.conf "${D}"/etc/

#	dobin natmonitord || die "dobin failed"
#	dobin natmonitor || die "dobin failed"
#	dobin natmonitorconsole || die "dobin failed"
}
