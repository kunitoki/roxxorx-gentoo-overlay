# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/spatialite/spatialite-2.4.0_rc4.ebuild,v 1.3 2011/08/07 12:03:49 maekke Exp $

EAPI="4"

inherit multilib eutils

DESCRIPTION="A complete Spatial DBMS in a nutshell built upon sqlite"
HOMEPAGE="https://www.gaia-gis.it/fossil/libspatialite/index"
SRC_URI="http://www.gaia-gis.it/gaia-sins/${P}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+geos iconv +proj xls"

RDEPEND=">=dev-db/sqlite-3.7.5:3[extensions]
    >=sci-libs/libgaiagraphics-0.4b
	geos? ( sci-libs/geos )
	proj? ( sci-libs/proj )
	xls? ( >=dev-libs/freexl-1.0.0b )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}

src_configure() {
	econf \
		--disable-static \
		--disable-geosadvanced \
		--enable-geocallbacks \
		--enable-epsg \
		$(use_enable excel freexl) \
		$(use_enable geos) \
		$(use_enable iconv) \
		$(use_enable proj)
}

src_install() {
	default

	find "${ED}" -name '*.la' -exec rm -f {} +
}
