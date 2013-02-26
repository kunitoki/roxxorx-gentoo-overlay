# Copyright 2006-2007 Daniel Fischer, Danny Wilson
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# NOTE: neko's install.n checks for availability of optional libraries,
# prompting the user for a path if the library is not found.
# We disable this checking (with patch), and care for availability
# by using dependencies. The .ndlls will be built if the dependency
# is installed, but themselves installed only if the respecive
# USE flag is set.

inherit eutils depend.apache

EAPI=3

DESCRIPTION="Intermediate programming language, compiler, and virtual machine."
HOMEPAGE="http://nekovm.org/"
SRC_URI="http://nekovm.org/_media/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="-sqlite -mysql -apache2 -gtk"

RDEPEND="
	>=dev-libs/boehm-gc-6.6
	>=dev-libs/libpcre-4.4
	>=sys-libs/zlib-1.2.3
	sqlite? ( >=dev-db/sqlite-3.2.1-r3 )
	mysql? ( >=dev-db/mysql-5.0.44-r1 )
	gtk? ( >=x11-libs/gtk+-2.10.9 )
    "
DEPEND="${RDEPEND}
	>=dev-lang/ocaml-2.08.3
	gtk? ( >=dev-util/pkgconfig-0.21-r1 )
    "
want_apache2

# FWICT, the neko/nekoc binaries contain the std library,
# so stripping them would deprive them of their runtime environment.
RESTRICT="strip nomirror"

pkg_setup() {
    if !(built_with_use dev-libs/boehm-gc threads);
    then
        eerror "Cannot proceed: dev-libs/boehm-gc needs to be compiled with threads support!"
        eerror "Try USE=\"threads\" emerge boehm-gc"
        die
    fi

    if use apache2 && (built_with_use www-servers/apache threads);
    then
        eerror "Cannot proceed: www-servers/apache needs to be compiled WITHOUT threads support!"
        eerror "Try USE=\"-threads\" emerge apache"
        die
    fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
    epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
    sed -i -e "s:-Wall -O3:${CFLAGS}:" Makefile || die "CFLAGS Makefile 'sed' fix failed :'-( ..."
    sed -i -e "s:-O3 :${CFLAGS} :" src/tools/install.neko || die "CFLAGS install.neko 'sed' fix failed :'-( ..."

    emake -j1 || die "emake failed"
}

src_install() {
    exeinto /usr/bin

    doexe bin/{neko,nekoc,nekoml,nekotools}

    dolib.so bin/libneko.so

    insinto /usr/lib/neko
    doins bin/{std,regexp,zlib}.ndll

	if use sqlite ; then
		doins bin/sqlite.ndll
	fi

	if use mysql ; then
		doins bin/mysql.ndll
    fi

	if use gtk ; then
		doins bin/ui.ndll
	fi

    if use apache2 ; then
        insinto ${APACHE_MODULESDIR}
        doins bin/mod_neko2.ndll
        insinto ${APACHE_MODULES_CONFDIR}
        doins ${FILESDIR}/50_mod_neko.conf
    fi

    insinto /usr/include/neko
    doins vm/neko.h

    doenvd ${FILESDIR}/50neko
}

