# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit distutils

DESCRIPTION="Multiple GNOME terminals in one window."
HOMEPAGE="http://www.tenshu.net/terminator/"
SRC_URI="https://launchpad.net/terminator/trunk/${PV}/+download/${PN}_${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="python"

DEPEND="virtual/python
	>=x11-libs/vte-0.16"

RDEPEND="${DEPEND}"

pkg_setup() {

	if use python; then
		if ! built_with_use x11-libs/vte python; then
			eerror "You need to build x11-libs/vte with USE=python enabled."
			die "You need to build x11-libs/vte with USE=python enabled."
		else
			einfo "python bindings enabled for x11-libs/vte"
		fi
	fi
}

src_install() {
	DOCS="ChangeLog README"
	distutils_src_install
}

