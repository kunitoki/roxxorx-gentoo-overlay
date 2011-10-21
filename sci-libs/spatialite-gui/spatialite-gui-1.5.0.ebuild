# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="4"

inherit eutils

SPATIALITE_VERSION="3.0.0"
SPATIALITE_V="${SPATIALITE_VERSION}-BETA"

MY_PN="spatialite_gui"
MY_P="${MY_PN}-${PV}-beta"

DESCRIPTION="SpatiaLite Graphical User Interface"
HOMEPAGE="http://www.gaia-gis.it/spatialite"
SRC_URI="http://www.gaia-gis.it/spatialite-${SPATIALITE_V}/${MY_P}.tar.gz"

LICENSE="MPL-1.1"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""

RDEPEND=">=dev-db/spatialite-${SPATIALITE_VERSION}
         =sci-libs/libgaiagraphics-0.4
		>=sci-libs/freexl-0.0.2
        >=x11-libs/wxGTK-2.8.10"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure()
{
    cd "${S}"

    econf

	# Fix wrong hard coded paths
	sed -e "s:/usr/local/:/usr/:g" -i ./Makefile

    emake || die "emake failed"
}


src_install()
{
	emake DESTDIR="${D}" || die "einstall failed"

	dobin "${S}"/${MY_PN}
}
