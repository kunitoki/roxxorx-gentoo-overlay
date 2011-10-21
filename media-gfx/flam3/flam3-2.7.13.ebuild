# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/httping/httping-1.2.5.ebuild,v 1.1 2008/01/27 19:11:27 cedk Exp $

inherit eutils

DESCRIPTION="Cosmic Recursive Fractal Flames"
HOMEPAGE="http://flam3.com"
SRC_URI="http://flam3.com/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ssl"

DEPEND="dev-libs/libxml2
        sys-libs/zlib"
RDEPEND="${DEPEND}"

src_unpack() {
    unpack ${A}
    cd "${S}"

#    epatch "${FILESDIR}"/${P}-destdir.patch
#    epatch "${FILESDIR}"/${P}-parallel_build.patch
}

src_compile() {
    econf || die "econf failed"
    emake || die "emake failed"
}

src_install() {
    make DESTDIR="${D}" install || die "install failed"
}
