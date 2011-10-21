# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="2"

inherit eutils

KEYWORDS="~x86 ~amd64"

SPATIALITE_VERSION="2.4.0"

S=${WORKDIR}/${P}

DESCRIPTION="Graphics library to be used by SpatiaLite extensions."
HOMEPAGE="http://www.gaia-gis.it/spatialite"
SRC_URI="http://www.gaia-gis.it/spatialite-${SPATIALITE_VERSION}-4/${P}.tar.gz"

LICENSE="MPL-1.1"

SLOT="0"
IUSE=""

RDEPEND="sys-libs/zlib
  media-libs/libpng
  media-libs/jpeg
  media-libs/tiff
  sci-libs/libgeotiff
  sci-libs/proj
  x11-libs/cairo"
DEPEND="${RDEPEND}"

src_configure()
{
	econf --enable-autoconf \
		|| die "Error: econf failed"
}

src_install()
{
	emake DESTDIR="${D}" install || die "einstall failed"
}

