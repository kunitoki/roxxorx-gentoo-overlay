# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 

inherit eutils

DESCRIPTION="Phasis è un gestionale che adotta una tradizionale interfaccia grafica"
HOMEPAGE="http://www.phasis.it/"
SRC_URI="http://phasis.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# DEPEND=""
RDEPEND=">=dev-lang/python-2.4
         >=dev-python/pysqlite-2.3.5
         >=dev-python/imaging-1.1.5
         >=dev-python/wxpython-2.6.4.0
         >=dev-python/reportlab-1.20"

src_install() {
#    
#    dodir /etc
#    cp ${S}/${PN}.conf "${D}"/etc/
#    cp ${S}/${PN}d.conf "${D}"/etc/
#	dobin natmonitord || die "dobin failed"
#	dobin natmonitor || die "dobin failed"
#	dobin natmonitorconsole || die "dobin failed"
    true
}
