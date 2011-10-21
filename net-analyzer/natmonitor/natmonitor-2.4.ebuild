# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/httping/httping-1.2.5.ebuild,v 1.1 2008/01/27 19:11:27 cedk Exp $

inherit eutils

DESCRIPTION="A tool to monitor internet hosts bandwidth usage in a Linux-NAT network"
HOMEPAGE="http://natmonitor.sourceforge.net/"
SRC_URI="http://freshmeat.net/redir/natmonitor/38948/url_tgz/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/gtk+
        net-libs/libpcap"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}"

src_compile() {
	emake || die "emake failed"
}

src_install() {
    
    dodir /etc
    cp ${S}/${PN}.conf "${D}"/etc/
    cp ${S}/${PN}d.conf "${D}"/etc/

	dobin natmonitord || die "dobin failed"
	dobin natmonitor || die "dobin failed"
	dobin natmonitorconsole || die "dobin failed"
}
