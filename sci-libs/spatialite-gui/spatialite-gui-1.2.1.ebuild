# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="2"

inherit eutils

KEYWORDS="~x86 ~amd64"

DESCRIPTION="SpatiaLite Graphical User Interface"
HOMEPAGE="http://www.gaia-gis.it/spatialite"
SRC_URI="http://www.gaia-gis.it/spatialite-2.3.1/${P}.tar.gz"

LICENSE="MPL-1.1"

SLOT="0"
IUSE=""

RDEPEND="=sci-libs/spatialite-2.3.1
        =sci-libs/rasterlite-1.0
        >=x11-libs/wxGTK-2.8.10"
DEPEND="${RDEPEND}"

src_configure()
{
	econf --enable-autoconf \
		--with-spatialite-lib=/usr/lib \
		|| die "econf failed"
}

src_install()
{
	emake DESTDIR="${D}" install || die "einstall failed"
}
