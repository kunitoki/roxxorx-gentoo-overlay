# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="2"

inherit distutils

DESCRIPTION="python ODBC module to connect to almost any database"
HOMEPAGE="http://code.google.com/p/pyodbc"
SRC_URI="http://pyodbc.googlecode.com/files/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mssql"

DEPEND=">=dev-lang/python-2.4
	>=dev-db/unixODBC-2.2.11-r1"
RDEPEND="${DEPEND}
	mssql? ( >=dev-db/freetds-0.62.3[odbc] )"

PYTHON_DEPEND="2:2.4"

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install
}
