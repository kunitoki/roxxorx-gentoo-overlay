# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

EAPI=3

DESCRIPTION="web oriented universal language"
HOMEPAGE="http://haxe.org/"
SRC_URI="http://haxe.org/_media/install.ml"

LICENSE="GPL"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="+neko"

RDEPEND="
	>=sys-libs/zlib-1.2.3
	neko? ( >=dev-lang/neko-1.8.1 )
    "
DEPEND="${RDEPEND}
	>=dev-lang/ocaml-3.08.3
    "

#TODO: MAYBE NOT? this is from neko
#FWICT, the neko/nekoc binaries contain the std library,
# so stripping them would deprive them of their runtime environment.
RESTRICT="nostrip nomirror"

src_unpack() {
	cp ${DISTDIR}/install.ml ./
}

src_compile() {
    ocaml install.ml || die "ocaml-based installation failed"

	ecvs_clean

	if use neko ; then
		bin/haxe -cp haxe/std/ -neko haxelib.n -main tools.haxelib.Main || die "cannot compile haxelib"
		nekotools boot haxelib.n || die "\"nekotools boot\" failed"

		bin/haxe -cp haxe/std/ -neko haxedoc.n -main tools.haxedoc.Main || die "cannot compile haxedoc"
		nekotools boot haxedoc.n || die "\"nekotools boot\" failed"
	else
		ewarn "haxelib and haxedoc will not be built. USE=neko to enable."
	fi
}

src_install() {
    exeinto /usr/bin
    doexe bin/haxe

	if use neko ; then
		doexe haxelib
		doexe haxedoc
	fi

    keepdir /usr/share/haxe
    cp -r haxe/std ${D}/usr/share/haxe

    doenvd ${FILESDIR}/50haxe
}

