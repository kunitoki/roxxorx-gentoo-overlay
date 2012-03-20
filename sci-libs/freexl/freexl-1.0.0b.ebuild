# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit eutils multilib

DESCRIPTION="An open source C library extracting data from Excel binary files (.xls)"
HOMEPAGE="https://www.gaia-gis.it/fossil/freexl/index"
SRC_URI="http://www.gaia-gis.it/gaia-sins/${P}.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
