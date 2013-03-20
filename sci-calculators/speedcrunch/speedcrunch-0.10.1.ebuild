# Copyright 2006-2008 Marco Wegner <devel@marcowegner.de>

EAPI=4

inherit eutils qt4-r2

DESCRIPTION="A fast and usable calculator for power users."
HOMEPAGE="http://speedcrunch.org/"
SRC_URI="http://speedcrunch.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nls"
RESTRICT="nomirror"

DEPEND=">=x11-libs/qt-core-4.5.0_rc1
        >=x11-libs/qt-gui-4.5.0_rc1
        >=dev-util/cmake-2.4.6"

src_compile()
{
    cmake -DCMAKE_INSTALL_PREFIX=/usr src || die "cmake failed"
    emake || die "emake failed"

    if use nls ; then
        for i in "${S}/src/i18n/*.ts"; do
            lrelease ${i} || die "lrelease failed";
        done
    else
        sed -e "/Translations/d" "${S}/src/CMakeLists.txt" || die "sed failed"
    fi
}

src_install()
{
    emake DESTDIR="${D}" install || die "emake install failed"

    # install the docs
    dodoc ChangeLog Changelog.floatnum HACKING.txt LISEZMOI PACKAGERS README TRANSLATORS
}

