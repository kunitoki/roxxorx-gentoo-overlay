# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libecwj2/libecwj2-3.3.ebuild,v 1.4 2008/10/04 00:57:46 darkside Exp $

inherit eutils

DESCRIPTION="This library offers read (decompress) and write (compress) for both the ECW and the ISO JPEG 2000 image file formats"
SRC_URI="mirror://gentoo/${P}-2006-09-06.zip"
HOMEPAGE="http://www.ermapper.com/ProductView.aspx?t=28"

LICENSE="ECWPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND="virtual/libc
	app-arch/unzip
	sys-devel/automake:1.7"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-nolcms.patch"
}

src_compile() {
	einfo "Running autoreconf"
	autoreconf -f -i || die "autoreconf failed"
	econf
	emake || die "emake failed"
}

src_install() {
	into /usr
	mkdir -p "${D}usr/include"	# hack to enable install of include files
	emake DESTDIR="${D}" install || die "make install failed"

	if use doc; then
		dodoc SDK.pdf
	fi
	if use examples; then
		dodir /usr/share/doc/${P}/
		cp -r ./examples/ "${D}"usr/share/doc/${P}/
	fi
}
