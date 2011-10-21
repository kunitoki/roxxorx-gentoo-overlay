# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-sendto/nautilus-sendto-0.8.ebuild,v 1.3 2006/12/07 04:24:49 compnerd Exp $

inherit eutils autotools

DESCRIPTION="JSDB is JavaScript for databases, a scripting language for data-driven, network-centric programming"
HOMEPAGE="http://www.jsdb.org"
SRC_URI="http://www.jsdb.org/jsdb_linux_${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="examples"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/"
EXAMPLEDIR="/usr/share/${PN}"

src_unpack() {
	unpack "${A}"
}

#src_compile() {
#    null
#}

src_install() {
	dobin ${S}/${PN}

	if use examples; then
		dodir ${EXAMPLEDIR}
		cp *.js  "${D}"/${EXAMPLEDIR}
		cp *.html  "${D}"/${EXAMPLEDIR}
		cp *.xml  "${D}"/${EXAMPLEDIR}
	fi
}
