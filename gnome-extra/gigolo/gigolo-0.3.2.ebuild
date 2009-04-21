# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit multilib gnome2-utils

DESCRIPTION="Gigolo is a frontend to easily manage connections to remote filesystems using GIO/GVfs"
HOMEPAGE="http://www.uvena.de/gigolo/index.html"
SRC_URI="http://files.uvena.de/gigolo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

src_configure() {
	./waf \
		--prefix="/usr/" \
		--libdir="/usr/$(get_libdir)" \
		configure || die "configure failed"
}

src_compile() {
	./waf build || die "build failed"
}

src_install() {
	DESTDIR=${D} ./waf install || die "install failed"
#	dodoc AUTHORS ChangeLog INSTALL TODO
}

pkg_postinst() {
	gnome2_icon_cache_update
#	ewarn "Midori tends to crash due to bugs in WebKit."
#	ewarn "Report bugs at http://www.twotoasts.de/bugs"
}

