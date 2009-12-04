# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="2"

inherit eutils

KEYWORDS="~x86 ~amd64"

MY_P=lib${PN}-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Raterlite a library supporting Raster Data Sources within a SpatiaLite DB."
HOMEPAGE="http://www.gaia-gis.it/spatialite"
SRC_URI="http://www.gaia-gis.it/spatialite/${MY_P}.tar.gz"

LICENSE="MPL-1.1"

SLOT="0"
IUSE="jpeg png proj tiff"

RDEPEND=">=dev-db/sqlite-3
        =dev-db/spatialite-2.3.1
        sys-libs/zlib
        png? ( media-libs/libpng )
        tiff? ( media-libs/tiff sci-libs/libgeotiff )
        jpeg? ( media-libs/jpeg )
        proj? ( sci-libs/proj )"
DEPEND="${RDEPEND}"

src_configure()
{
	econf || die "Error: econf failed"
}

src_install()
{
	emake DESTDIR="${D}" install || die "einstall failed"
}
