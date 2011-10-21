# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit multilib

DESCRIPTION="An open source C library extracting data from Excel binary files (.xls)"
HOMEPAGE="http://www.gaia-gis.it/FreeXL"
SRC_URI="http://www.gaia-gis.it/FreeXL/${P}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}

src_configure() {
	econf \
		--disable-static
}

src_install() {
	default

	find "${ED}" -name '*.la' -exec rm -f {} +
}
