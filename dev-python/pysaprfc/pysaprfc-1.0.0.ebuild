# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pychart/pychart-1.39.ebuild,v 1.5 2007/07/11 06:19:47 mr_bones_ Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="Python library for SAP RFC communication"
HOMEPAGE="http://pysaprfc.sourceforge.net/"
SRC_URI="http://downloads.sourceforge.net/project/${PN}/${PN}/${PV}/${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE="examples"

DEPEND=""

S=${WORKDIR}/${PN}

src_install() {
    distutils_src_install
    if use examples ; then
        insinto /usr/share/doc/${PF}/examples
        doins example/*
    fi
}

