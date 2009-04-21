# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

UNIPATCH_LIST="${DISTDIR}/linux-${KV}.bz2"
K_PREPATCHED="yes"
K_NOUSENAME="yes"
UNIPATCH_STRICTORDER="yes"

ETYPE="sources"
inherit eutils kernel-2
detect_version

DESCRIPTION="Kamikaze-Sources is an experimental kernel patchset with many new features."
HOMEPAGE="http://kamikaze.waninkoko.info"

KEYWORDS="~x86 ~amd64 ~ppc ~ppc64"
RESTRICT="nomirror"

SRC_URI="${KERNEL_URI}
        http://kamikaze.waninkoko.info/patches/${OKV}/${EXTRAVERSION/-}/linux-${KV}.bz2
	http://www.dottout.com/patches/${OKV}/${EXTRAVERSION/-}/linux-${KV}.bz2"

src_install() {
	kernel-2_src_install
}

pkg_postinst() {
        postinst_sources

	einfo "Kamikaze-Sources by Miguel Boton <mboton@gmail.com> - http://kamikaze.waninkoko.info"
	einfo "If you have any problem feel free to contact me."
}
