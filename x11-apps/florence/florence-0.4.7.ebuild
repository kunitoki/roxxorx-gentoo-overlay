
EAPI="2"

inherit gnome2 eutils

HOMEPAGE="http://sourceforge.net/projects/florence/"
DESCRIPTION="Florence is an extensible scalable on-screen virtual keyboard for GNOME"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2 GFDL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.18.6"
DEPEND="${RDEPEND}
	>=app-text/gnome-doc-utils-0.18.1"

src_configure() {
        gnome2_src_configure
}

src_compile() {
        default
}

pkg_postinst() {
        gnome2_pkg_postinst
}

#src_install() {
#    emake DESTDIR="${D}" install || die "make install failed!"
#}
