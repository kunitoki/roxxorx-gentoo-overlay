# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnome2

DESCRIPTION="a user interface to the stochastic system profiler OProfile"
HOMEPAGE="http://projects.o-hand.com/oprofileui"
SRC_URI="http://projects.o-hand.com/sources/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-perl/XML-Parser
	>=dev-libs/glib-2.0
	>=gnome-base/libglade-2.0
	>=x11-libs/gtk+-2.0
	>=dev-libs/libxml2-2.0
	>=gnome-base/gnome-vfs-2.0"
RDEPEND="${DEPEND}
	dev-util/oprofile
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.35"

