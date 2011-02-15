# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="2"

inherit eutils

KEYWORDS="~x86 ~amd64"

SPATIALITE_VERSION="2.4.0"

DESCRIPTION="SpatiaLite Graphical User Interface"
HOMEPAGE="http://www.gaia-gis.it/spatialite"
SRC_URI="http://www.gaia-gis.it/spatialite-${SPATIALITE_VERSION}-4/spatialite_gui-${PV}.tar.gz"

LICENSE="MPL-1.1"

SLOT="0"
IUSE=""

RDEPEND="=sci-libs/spatialite-${SPATIALITE_VERSION}-r4
        >=sci-libs/rasterlite-1.0
        >=x11-libs/wxGTK-2.8.10"
DEPEND="${RDEPEND}"

src_configure()
{
    cd "${S}"

	# Fix wrong hard coded paths
	sed -e "s:/usr/local/lib:/usr/lib:g" -i ./Makefile
}

src_install()
{
	emake DESTDIR="${D}" || die "einstall failed"

	dobin "${S}"/bin/${PN}
}