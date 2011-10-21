# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI="2"

inherit eutils

DESCRIPTION="General framework for developing spatial indices"
HOMEPAGE="http://trac.gispython.org/spatialindex/wiki"
SRC_URI="http://download.osgeo.org/libspatialindex/${P}.tar.gz"

LICENSE="GPL-2.0"

KEYWORDS="~x86 ~amd64"

SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

#src_configure()
#{
#    cd "${S}"
#}

src_install()
{
	emake DESTDIR="${D}" || die "emake failed"
	emake DESTDIR="${D}" install || die "einstall failed"
}
