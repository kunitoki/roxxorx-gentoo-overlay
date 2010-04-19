# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools

ZARAFA_PATCHES="zarafa-ical-patches.tar.gz"

DESCRIPTION="a implementation of basic iCAL protocols"
HOMEPAGE="http://www.softwarestudio.org"
SRC_URI="http://download.zarafa.com/mirror/${P}.tar.gz
      http://developer.zarafa.com/download/${ZARAFA_PATCHES}"

LICENSE="|| ( MPL-1.1 LGPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static"

src_unpack() {
	unpack ${A}
	mv *.diff ${S}
	cd "${S}"
	for x in *.diff; do
		epatch "${x}";
	done
	epatch ${FILESDIR}/disable-test.patch
}

src_compile() {
	for x in icalderivedparameter.c icalderivedvalue.c icalderivedproperty.c; do
		rm src/libical/${x};
	done
	eautoreconf
	econf \
		--disable-python-bindings \
		$(use_enable static)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TEST THANKS TODO doc/*.txt
} 
