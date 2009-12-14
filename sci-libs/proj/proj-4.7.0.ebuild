# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/proj/proj-4.7.0.ebuild,v 1.1 2009/10/03 20:44:04 patrick Exp $

inherit eutils

DESCRIPTION="Proj.4 cartographic projection software with updated NAD27 grids"
HOMEPAGE="http://trac.osgeo.org/proj/"
SRC_URI="ftp://ftp.remotesensing.org/pub/proj/${P}.tar.gz
	http://download.osgeo.org/proj/${PN}-datumgrid-1.4.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

RDEPEND=""
DEPEND="app-arch/unzip"

src_unpack() {
	unpack ${P}.tar.gz || die
	cd "${S}"/nad
	mv README README.NAD
	unpack ${PN}-datumgrid-1.4.zip || die
	#epatch "${FILESDIR}/${P}-test.patch"

	# fix for spherical mercator
	echo "# Mercator" >> epsg
	echo "<54004> +proj=merc +lat_ts=0 +lon_0=0 +k=1.000000 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m no_defs <>" >> epsg
	echo "# Spherical Mercator" >> epsg
	echo "<900913> +proj=merc +lon_0=0 +lat_ts=0 +x_0=0 +y_0=0 +a=6378137 +b=6378137 +units=m +no_defs  <>" >> epsg
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README NEWS AUTHORS INSTALL ChangeLog nad/README.{NAD,NADUS}
	cd nad
	insinto /usr/share/proj
	insopts -m 755
	doins test27 test83 || die
	insopts -m 644
	doins pj_out27.dist pj_out83.dist || die
}
