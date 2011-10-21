# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils autotools wxwidgets

DESCRIPTION="wxWidgets GUI Designer for C++ and Python"
HOMEPAGE="http://wxformbuilder.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="unicode debug"

WX_GTK_VER="2.6" #needed for wxwidgets.eclass

RDEPEND="=x11-libs/wxGTK-${WX_GTK_VER}*
	x11-libs/gtkscintilla2*"

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

src_unpack()	# This function unpacks our files
{
	mkdir -p ${S}			# S is our source dir, where we copy our source files to
	svn co http://wxformbuilder.svn.sourceforge.net/svnroot/wxformbuilder/3.x/trunk ${S}/wxformbuilder
}

src_compile()
{
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.7

	local TMP

	TMP="/usr/share/aclocal/libtool.m4"
	einfo "Running ./create_build_files.sh"
	if [ -e "$TMP" ]; then
		cp "$TMP" aclocal.m4 || die "cp failed"
	fi

	cd ${S}/wxformbuilder
	./create_build_files.sh || die "boostrap failed"

	# patch for AMD64 -fPIC problem
	if [ ${ARCH} = amd64 ]; then
		for i in sdk/plugin_interface/Makefile sdk/tinyxml/Makefile plugins/additional/Makefile; do
			einfo "Patching makefile $i for AMD64"
			if [ -e $i ]; then
				mv $i $i.shipped && \
				sed -e 's/\(CFLAGS += .*$\)/\1 -fPIC/' $i.shipped >$i
				if [ $? != 0 ]; then
					die "error patching makefiles"
				fi
			fi
		done
	fi

	if use debug; then
		CF=Debug
	else
		CF=Release
	fi

	export LD_LIBRARY_PATH=${S}/wxformbuilder/output/lib

	CONFIG=${CF} emake || die "emake failed"
}

src_install()
{
	# D is like a virtual / where we install our stuff, before emerge merge it with the real /
	wxfb_root=${S}/wxformbuilder/output
	rm -f $wxfb_root/output
	rm -f $wxfb_root/share/wxformbuilder
	mkdir $wxfb_root/share/wxformbuilder
	mkdir -p $wxfb_root/share/doc/wxformbuilder
	mv $wxfb_root/Changelog.txt $wxfb_root/share/doc/wxformbuilder
	mv $wxfb_root/license.txt $wxfb_root/share/doc/wxformbuilder
	mv $wxfb_root/{xml,plugins,resources} $wxfb_root/share

	wxfb_dest=${D}/tmp/wxformbuilder
	cd $wxfb_root
	mkdir -p $wxfb_dest
	find . -depth | cpio -pvdm $wxfb_dest
}
