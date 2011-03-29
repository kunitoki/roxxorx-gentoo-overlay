# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnome2

DESCRIPTION="GNOME interface to Subversion"
HOMEPAGE="http://www.sf.net/projects/gnubversion"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.0
	>=gnome-base/nautilus-2.0
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/gnome-vfs-2.0
	>=gnome-base/libglade-2.0
	>=dev-libs/apr-1.0"

DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog"
G2CONF=$(use_enable debug)

