# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libecwj2/libecwj2-3.3.ebuild,v 1.3 2007/02/01 22:55:29 djay Exp $

inherit eutils

DESCRIPTION="This library offers read (decompress) and write (compress) for both the ECW and the ISO JPEG 2000 image file formats"
SRC_URI="ImageCompressionSDKSourceCode${PV}Setup_20070509.zip"
HOMEPAGE="http://www.ermapper.com/ProductView.aspx?t=28"

LICENSE="ECWPL"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc examples"
RESTRICT="fetch strip"

DEPEND="virtual/libc"

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e 's:NCSScreenPoint.cpp:NCSScreenPoint.cpp ..\/tinyxml\/tinystr.cpp ..\/tinyxml\/tinyxml.cpp ..\/tinyxml\/tinyxmlerror.cpp ..\/tinyxml\/tinyxmlparser.cpp:g' \
		"${S}/Source/C/NCSUtil/makefile" || die "sed makefile failed"
}

src_install() {
    into /usr
    mkdir -p "${D}usr/include"  # hack to enable install of include files
    make DESTDIR=${D} install || die "make install failed"
    if use doc; then
        dodoc SDK.pdf
    fi
    if use examples; then
        dodir /usr/share/doc/${P}/
        cp -r ./examples/ "${D}"usr/share/doc/${P}/
    fi
}
