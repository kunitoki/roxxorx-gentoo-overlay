# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="2"

inherit eutils

KEYWORDS="~x86 ~amd64"

DESCRIPTION="SpatiaLite CLI tools"
HOMEPAGE="http://www.gaia-gis.it/spatialite"
SRC_URI="http://www.gaia-gis.it/spatialite-${PV}-4/${P}.tar.gz"

LICENSE="MPL-1.1"

SLOT="0"
IUSE="geos proj readline"

RDEPEND="=sci-libs/spatialite-${PV}-r4
        geos? ( >=sci-libs/geos-3.1 sci-libs/spatialite[geos] )
        proj? ( sci-libs/proj sci-libs/spatialite[proj] )
        readline? ( sys-libs/readline sci-libs/spatialite[readline] )"
DEPEND="${RDEPEND}"

src_configure()
{
	econf --enable-autoconf \
		--with-spatialite-lib=/usr/lib \
		$(use_enable geos) --with-geos-lib=/usr/lib \
		$(use_enable proj) --with-proj-lib=/usr/lib \
		$(use_enable readline) \
		|| die "econf failed"
}

src_install()
{
	emake DESTDIR="${D}" install || die "einstall failed"
}