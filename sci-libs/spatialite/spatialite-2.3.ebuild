# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/gdal/gdal-1.5.1.ebuild,v 1.2 2008/05/21 19:01:41 dev-zero Exp $

inherit autotools distutils eutils toolchain-funcs

DESCRIPTION="SpatiaLite extension enables SQLite to support spatial data in a way conformant to OpenGis specifications"
HOMEPAGE="http://www.gaia-gis.it/spatialite-2.3/"
SRC_URI="http://www.gaia-gis.it/spatialite-2.3/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL"
KEYWORDS="~amd64 ~x86"

IUSE="proj geos readline static"

RDEPEND=">=dev-db/sqlite-3
		proj? ( >=sci-libs/proj-4.4.9 )
		geos? ( >=sci-libs/geos-2.2.1 )
		readline? ( sys-libs/readline )"

DEPEND="${RDEPEND}"

src_unpack() {

	unpack ${A}

	cd "${S}"

}

src_compile() {

	local pkg_conf="--enable-mathsql"
	local use_conf=""

    if use geos ; then
        use_conf="--enable-geos --with-geos-prefix=/usr ${use_conf}"
    fi

    if use proj ; then
        use_conf="--enable-proj --with-proj-prefix=/usr ${use_conf}"
    fi

    if use readline ; then
        use_conf="--enable-readline ${use_conf}"
    fi

    if use static ; then
        use_conf="--enable-static ${use_conf}"
	fi

	econf ${pkg_conf} ${use_conf} || die "econf failed"

	emake || die "emake failed"
}

src_install() {

	make DESTDIR="${D}" install || die "make install failed"

	dodoc README
}

pkg_postinst() {
	elog
	elog "If you need a gui for managing spatialite sqlite database, then"
	elog "you can emerge spatialite-gui afterwards:"
	elog
	elog "emerge -av spatialite-gui"
	elog
}
