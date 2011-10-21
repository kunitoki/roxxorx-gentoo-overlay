# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils

DESCRIPTION="Manipulation tool for Macromedia Flash Video Files (flv)"
HOMEPAGE="http://www.inlet-media.de/flvtool2"
SRC_URI="http://rubyforge.org/frs/download.php/17497/${PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-lang/ruby"
DEPEND="${RDEPEND}"

DOCS="CHANGELOG LICENSE README"

src_compile() {
    ruby setup.rb config || die "config failed"
    ruby setup.rb setup || die "setup failed"
}

src_install() {
    ruby setup.rb install --prefix=${D} || die "install failed"
}

