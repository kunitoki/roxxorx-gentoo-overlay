# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils waf-utils

DESCRIPTION="Thunar Dropbox is a plugin for thunar that adds context-menu items from dropbox."
HOMEPAGE="http://softwarebakery.com/maato/${PN}.html"
SRC_URI="http://softwarebakery.com/maato/files/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="net-misc/dropbox"
RDEPEND="${DEPEND}"

src_unpack() {
    unpack ${A}
    cd "${S}"

    epatch "${FILESDIR}/sandbox-violation.patch"
}

src_configure() {
    waf-utils_src_configure
}

src_compile() {
    waf-utils_src_compile
}

src_install() {
    waf-utils_src_install
}
