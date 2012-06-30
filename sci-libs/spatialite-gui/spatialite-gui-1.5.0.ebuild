# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="4"

inherit eutils

MY_PN="spatialite_gui"
MY_P="${MY_PN}-${PV}-stable"

DESCRIPTION="SpatiaLite Graphical User Interface"
HOMEPAGE="https://www.gaia-gis.it/fossil/spatialite_gui/index"
SRC_URI="http://www.gaia-gis.it/gaia-sins/${MY_P}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-db/spatialite-3.0.1
        >=sci-libs/libgaiagraphics-0.4b
        >=dev-libs/freexl-1.0.0b
        >=x11-libs/wxGTK-2.8.10"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

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
