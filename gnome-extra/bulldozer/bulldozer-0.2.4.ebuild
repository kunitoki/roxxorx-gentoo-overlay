# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-sendto/nautilus-sendto-0.8.ebuild,v 1.3 2006/12/07 04:24:49 compnerd Exp $

inherit gnome2 eutils autotools

DESCRIPTION="Lot of useful nautilus extensions"
HOMEPAGE="http://taschenorakel.de/mathias/bulldozer/"
SRC_URI="http://taschenorakel.de/svn/repos/bulldozer/releases/${PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.4
		 >=dev-libs/glib-2.4
		 >=gnome-base/libglade-2.5.1
		 >=gnome-base/libbonobo-2.13.0
		 >=gnome-base/libbonoboui-2.13.0
		 >=gnome-base/libgnome-2.13.0
		 >=gnome-base/libgnomeui-2.13.0
		 >=gnome-base/nautilus-2.13.3
		 >=gnome-base/gconf-2.13.0"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS README"

#src_unpack() {
#	unpack ${A}
#}

src_compile() {
    emake || die "make failed"
}

