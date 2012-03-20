# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="4"

inherit eutils multilib

DESCRIPTION="Raterlite a library supporting Raster Data Sources within a SpatiaLite DB."
HOMEPAGE="https://www.gaia-gis.it/fossil/librasterlite/index"
SRC_URI="http://www.gaia-gis.it/gaia-sins/${P}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=sci-libs/libspatialite-3.0.1
        sys-libs/zlib
        media-libs/libpng
        media-libs/tiff
        sci-libs/libgeotiff
        media-libs/jpeg
        sci-libs/proj"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_configure()
{
	econf || die "Error: econf failed"
}

src_install()
{
	emake DESTDIR="${D}" install || die "einstall failed"
}
