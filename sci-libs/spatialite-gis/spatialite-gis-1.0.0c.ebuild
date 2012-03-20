# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="4"

inherit eutils

MY_PN="spatialite_gis"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="SpatiaLite GIS"
HOMEPAGE="https://www.gaia-gis.it/fossil/spatialite_gis/index"
SRC_URI="http://www.gaia-gis.it/gaia-sins/${MY_P}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=sci-libs/libspatialite-3.0.1
        >=sci-libs/librasterlite-1.1b
	media-libs/libharu
        >=x11-libs/wxGTK-2.8.10"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_configure()
{
	cd "${S}"

	econf --enable-autoconf \
		|| die "Error: econf failed"
}

src_install()
{
	emake DESTDIR="${D}" || die "einstall failed"

	dobin "${S}"/${MY_PN}
}
