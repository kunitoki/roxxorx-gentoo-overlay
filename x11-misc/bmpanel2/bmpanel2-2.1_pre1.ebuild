# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit cmake-utils

MY_PV=${PV/_/}
DESCRIPTION="NETWM compliant panel for X"
HOMEPAGE="http://code.google.com/p/bmpanel2/"
SRC_URI="http://${PN}.googlecode.com/files/${PN}-${MY_PV}.tar.gz"

S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+cfg doc"

DEPEND="
	x11-libs/pango
	x11-libs/cairo
	x11-libs/libX11
	cfg? ( dev-lang/python
		   dev-python/pygtk )
	media-fonts/dejavu
	dev-libs/glib
	doc? ( app-text/docbook-xsl-stylesheets
		   app-text/asciidoc )
"
RDEPEND="${DEPEND}"

DOCS="INSTALL COPYING"
CMAKE_IN_SOURCE_BUILD="1"

src_configure()
{
    mycmakeargs="${mycmakeargs}
        $(cmake-utils_use_use cfg CONFIG)
        $(cmake-utils_use_use doc MANPAGE)"

	cmake-utils_src_configure
}

