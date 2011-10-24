# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="4"

inherit eutils

DESCRIPTION="SpatiaLite CLI tools"
HOMEPAGE="http://www.gaia-gis.it/spatialite"
SRC_URI="http://www.gaia-gis.it/OpenLite/${P}.tar.gz"

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="postgres mysql"

RDEPEND="dev-db/sqlite
		>=x11-libs/wxGTK-2.8.10
		postgres? (
			>=dev-db/postgresql-base-8.3
			>=dev-db/postgis-1.5.2
		)
		mysql? (
			dev-db/mysql
		)"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}"

src_configure()
{
    cd "${S}"

	econf \
		--enable-autoconf \
		$(use_enable postgres) \
		$(use_enable mysql) \
		|| die "econf failed"

	# Fix wrong hard coded paths
	sed -e "s:/usr/local/:/usr/:g" -i ./Makefile
}

src_install()
{
	emake DESTDIR="${D}" install || die "einstall failed"
}
