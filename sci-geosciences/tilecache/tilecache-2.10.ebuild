# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/httping/httping-1.2.5.ebuild,v 1.1 2008/01/27 19:11:27 cedk Exp $

inherit eutils

DESCRIPTION="TileCache is an implementation of a WMS-C compliant server"
HOMEPAGE="http://tilecache.org/"
SRC_URI="http://tilecache.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="apache doc"

DEPEND=">=dev-lang/python-2.5.0
        >=dev-python/imaging-1.1.5
        apache? ( www-apache/mod_python )"
RDEPEND="${DEPEND}"

BASE=/usr/share/webapps/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	if ! use doc ; then
		rm -Rf "${S}"/doc
	fi
}

src_install() {
	dodir /etc
	mv ${S}/tilecache.cfg "${D}"/etc/

	dodir ${BASE}
    cp -R ${S}/* "${D}"/${BASE}
}

# postinstall
# if apache enable mod_python
