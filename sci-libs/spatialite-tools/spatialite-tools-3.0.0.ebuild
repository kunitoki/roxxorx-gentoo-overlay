# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="4"

inherit eutils

SPATIALITE_VERSION="3.0.0"
SPATIALITE_V="${SPATIALITE_VERSION}-BETA"
MY_P="${P}-beta"


DESCRIPTION="SpatiaLite CLI tools"
HOMEPAGE="http://www.gaia-gis.it/spatialite"
SRC_URI="http://www.gaia-gis.it/spatialite-${SPATIALITE_V}/${MY_P}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="geos proj readline excel"

RDEPEND="=dev-db/spatialite-${SPATIALITE_VERSION}
        geos? ( >=sci-libs/geos-3.1 dev-db/spatialite[geos] )
        proj? ( sci-libs/proj dev-db/spatialite[proj] )
		excel? ( sci-libs/freexl )
        readline? ( sys-libs/readline )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure()
{
	econf \
		--enable-autoconf \
		--with-spatialite-lib=/usr/lib \
		$(use_enable geos) --with-geos-lib=/usr/lib \
		$(use_enable proj) --with-proj-lib=/usr/lib \
		$(use_enable excel freexl) \
		$(use_enable readline) \
		|| die "econf failed"
}

src_install()
{
	emake DESTDIR="${D}" install || die "einstall failed"
}
