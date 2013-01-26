# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit eutils multilib python bzr

DESCRIPTION="Disper is an on-the-fly display switch utility"
HOMEPAGE="http://willem.engen.nl/projects/disper/"
SRC_URI=""
EBZR_REPO_URI="lp:disper"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-vcs/bzr
  dev-lang/python"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${P}
instdir="/usr/share/${PN}"

src_compile() {
	sed -e "s:#PREFIX#/share/${PN}/src:$instdir:" < ${PN}.in > ${PN}
}

src_install() {
	for dir in "" $(find src -type d -print | sed -e 's#src##g') ; do
		insinto "${instdir}${dir}"
		doins "src${dir}"/*
	done
	dodoc README TODO
	dobin ${PN}
}
