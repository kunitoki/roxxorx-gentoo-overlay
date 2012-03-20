# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit eutils multilib

DESCRIPTION="Graphics library to be used by SpatiaLite extensions."
HOMEPAGE="https://www.gaia-gis.it/fossil/libgaiagraphics/index"
SRC_URI="http://www.gaia-gis.it/gaia-sins/${P}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="sys-libs/zlib
  media-libs/libpng
  virtual/jpeg
  media-libs/tiff
  sci-libs/libgeotiff
  sci-libs/proj
  x11-libs/cairo"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}

src_configure()
{
	econf --enable-autoconf \
		|| die "Error: econf failed"
}

src_install()
{
	emake DESTDIR="${D}" install || die "einstall failed"
}

