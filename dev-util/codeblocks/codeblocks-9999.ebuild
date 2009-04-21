# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools wxwidgets

DESCRIPTION="wxWidgets GUI Designer for C++ and Python"
HOMEPAGE="http://wxformbuilder.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="unicode contrib debug"

WX_GTK_VER="2.6" #needed for wxwidgets.eclass

RDEPEND="=x11-libs/wxGTK-${WX_GTK_VER}*"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.5
	>=sys-devel/automake-1.7
	>=sys-devel/libtool-1.4"

pkg_setup()
{
	if use unicode; then
		#check for gtk2-unicode
		need-wxwidgets unicode
	else
		#check for gtk2-ansi
		need-wxwidgets gtk2
	fi
}

src_unpack()
{	# S is our source dir, where we copy our source files to
	mkdir -p ${S}
	svn checkout svn://svn.berlios.de/codeblocks/trunk ${S}/codeblocks
}

src_compile()
{
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.7

	local TMP

	TMP="/usr/share/aclocal/libtool.m4"
	einfo "Running ./bootstrap"
	if [ -e "$TMP" ]; then
		cp "$TMP" aclocal.m4 || die "cp failed"
	fi
	cd ${S}/codeblocks
	./bootstrap || die "boostrap failed"

	econf --with-wx-config="${WX_CONFIG}" \
		$(use_enable contrib) \
		$(use_enable debug) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install()
{
	make -C ${S}/codeblocks install DESTDIR="${D}" || die "make install failed"
}
