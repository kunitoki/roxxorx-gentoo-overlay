# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="2"

inherit eutils

KEYWORDS="~x86 ~amd64"

SPATIALITE_VERSION="2.4.0"

MY_PN="spatialite_gui"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="SpatiaLite Graphical User Interface"
HOMEPAGE="http://www.gaia-gis.it/spatialite"
SRC_URI="http://www.gaia-gis.it/spatialite-${SPATIALITE_VERSION}-4/${MY_P}.tar.gz"

LICENSE="MPL-1.1"

SLOT="0"
IUSE=""

RDEPEND="=sci-libs/libspatialite-${SPATIALITE_VERSION}-r4
         =sci-libs/libgaiagraphics-0.4
        >=sci-libs/rasterlite-1.0
        >=x11-libs/wxGTK-2.8.10"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure()
{
    cd "${S}"

    econf

	# Fix wrong hard coded paths
	# sed -e "s:/usr/local/lib:/usr/lib:g" -i ./Makefile

    emake || die "emake failed"
}



src_install()
{
	emake DESTDIR="${D}" || die "einstall failed"

	dobin "${S}"/${MY_PN}
}

