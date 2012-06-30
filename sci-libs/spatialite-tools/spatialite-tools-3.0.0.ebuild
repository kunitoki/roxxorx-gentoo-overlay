# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="4"

inherit eutils

MY_P="${P}-stable"

DESCRIPTION="SpatiaLite CLI tools"
HOMEPAGE="https://www.gaia-gis.it/fossil/spatialite-tools/index"
SRC_URI="http://www.gaia-gis.it/gaia-sins/${MY_P}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="geos proj readline xls"

RDEPEND=">=sci-libs/libspatialite-3.0.1
        geos? ( >=sci-libs/geos-3.1 sci-libs/libspatialite[geos] )
        proj? ( sci-libs/proj sci-libs/libspatialite[proj] )
		xls? ( >=dev-libs/freexl-1.0.0b )
        readline? ( sys-libs/readline )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_configure()
{
	econf \
		--enable-autoconf \
		--with-spatialite-lib=/usr/lib \
		$(use_enable geos) --with-geos-lib=/usr/lib \
		$(use_enable proj) --with-proj-lib=/usr/lib \
		$(use_enable xls freexl) \
		$(use_enable readline) \
		|| die "econf failed"
}

src_install()
{
	emake DESTDIR="${D}" install || die "einstall failed"
}
