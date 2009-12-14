# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="2"

inherit eutils

KEYWORDS="~x86 ~amd64"

MY_P="lib${PN}-amalgamation-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="SpatiaLite extension enables SQLite to support spatial data in a way conformant to OpenGis specifications."
HOMEPAGE="http://www.gaia-gis.it/spatialite"
SRC_URI="http://www.gaia-gis.it/spatialite/${MY_P}.tar.gz"

LICENSE="MPL-1.1"

SLOT="0"
IUSE="geos proj readline"

RDEPEND=">=dev-db/sqlite-3
        geos? ( >=sci-libs/geos-3.1 )
        proj? ( sci-libs/proj )
        readline? ( sys-libs/readline )"
DEPEND="${RDEPEND}"

src_configure()
{
	econf --enable-autoconf \
		$(use_enable geos) --with-geos-lib=/usr/lib \
		$(use_enable proj) --with-proj-lib=/usr/lib \
		$(use_enable readline) \
		|| die "Error: econf failed"
}

src_install()
{
	emake DESTDIR="${D}" install || die "einstall failed"
}

pkg_postinst() {
    elog
    elog "If you need some applications to ease managing spatialite database, then"
    elog "you can emerge spatialite-tools afterwards:"
    elog
    elog "emerge -av spatialite-tools"
    elog
}

