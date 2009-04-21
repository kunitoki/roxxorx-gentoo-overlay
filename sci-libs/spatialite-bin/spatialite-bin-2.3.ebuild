# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/gdal/gdal-1.5.1.ebuild,v 1.2 2008/05/21 19:01:41 dev-zero Exp $

inherit distutils eutils toolchain-funcs

DESCRIPTION="SpatiaLite extension enables SQLite to support spatial data in a way conformant to OpenGis specifications"
HOMEPAGE="http://www.gaia-gis.it/spatialite-${PV}/"
SRC_URI="http://www.gaia-gis.it/spatialite-${PV}/spatialite-${PV}-linux-x86-bin.tar.gz
         http://www.gaia-gis.it/spatialite-${PV}/spatialite-${PV}-linux-x86-libs.tar.gz "

SLOT="0"
LICENSE="LGPL"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND=">=dev-db/sqlite-3
		 >=sci-libs/proj-4.4.9
		 >=sci-libs/geos-2.2.1
		 sys-libs/readline"

DEPEND="${RDEPEND}"

#src_unpack() {
#	unpack ${A}
#	cd "${S}"
#}

src_compile() {
	true
}

src_install() {

	insinto /usr/bin
    dobin exif_loader
    dobin shp_doctor
    dobin spatialite
    dobin spatialite_network

	insinto /usr/include
	doins include/spatialite.h
	insinto /usr/include/spatialite
	doins include/spatialite/*

	insinto /usr/lib
	dolib lib/libspatialite.*
	dolib lib/libvirtualtext.*

#    use doc && dodoc doc/docu_luise011_Linux.pdf
}

pkg_postinst() {
	elog
#	elog "If you need a gui for managing spatialite sqlite database, then"
#	elog "you can emerge spatialite-gui afterwards:"
#	elog
#	elog "emerge -av spatialite-gui"
#	elog
}
