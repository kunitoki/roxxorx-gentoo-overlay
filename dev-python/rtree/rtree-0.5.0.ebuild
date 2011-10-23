# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysnmp/pysnmp-4.1.12a.ebuild,v 1.1 2009/11/28 16:12:03 arfrever Exp $

EAPI="3"

inherit distutils

MY_PN=Rtree
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Spatial R-Tree index for Python GIS."
HOMEPAGE="http://trac.gispython.org/lab/wiki/Rtree"
SRC_URI="http://pypi.python.org/packages/source/R/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sci-libs/spatialindex-1.4.0"
RDEPEND="${DEPEND}"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

DOCS="CHANGES.txt CREDITS.txt DEPENDENCIES.txt FAQ.txt README.txt"

S="${WORKDIR}/${MY_P}"

src_configure()
{
    cd "${S}"

    # Fix wrong hard coded paths
    sed -e "s:ctypes.CDLL(lib_name):ctypes.CDLL(os.path.abspath(os.path.dirname(__file__))+'/../'+lib_name):g" -i ./rtree/core.py
}

src_install()
{
    distutils_src_install

#    dohtml docs/*.{html,gif}
#    insinto /usr/share/doc/${PF}
#    doins -r examples docs/mibs
}

pkg_postinst()
{
    distutils_pkg_postinst
}


