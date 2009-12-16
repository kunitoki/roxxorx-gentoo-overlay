# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="2"

inherit eutils

MY_P="${PN}-${PV}-ALPHA-1"

DESCRIPTION="SpatiaLite GIS"
HOMEPAGE="http://www.gaia-gis.it/spatialite"
SRC_URI="http://www.gaia-gis.it/spatialite-2.3.1/${MY_P}.tar.gz"

LICENSE="MPL-1.1"

KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""

RDEPEND="=sci-libs/spatialite-2.3.1
        =sci-libs/rasterlite-1.0
        >=x11-libs/wxGTK-2.8.10"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure()
{
    cd "${S}"

	# Fix wrong hard coded paths
	sed -e "s:/usr/local/lib:/usr/lib:g" -i ./Makefile

	# Fix wrong code supporting GCC4.3
	sed -e "s:double minx, double minx:double minx, double miny:g" -i ./Classdef.h
}

src_install()
{
	emake DESTDIR="${D}" || die "einstall failed"

	dobin "${S}"/bin/${PN}
}