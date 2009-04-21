# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils autotools distutils

DESCRIPTION="OpenSource Data Access Technology API for manipulating, defining and analyzing geospatial information."
HOMEPAGE="http://fdo.osgeo.org/"
SRC_URI="http://download.osgeo.org/${PN}/${PV}/${PN}-${PV}.tar.gz"

LICENSE="GPL"
KEYWORDS="~amd64 ~x86"

IUSE="sde gdal mysql python"
SLOT="0"

DEPEND="dev-libs/xalan-c
        dev-libs/xerces-c
        net-misc/curl
        dev-libs/openssl
        >=dev-util/cppunit-1.9.0
        >=dev-libs/boost-1.32.0
        dev-db/unixODBC"
RDEPEND="${DEPEND}"

S=${WORKDIR}/OpenSource_FDO

src_compile() {

    cd "${S}"

    # epatch "${FILESDIR}"/${P}-assorted.patch

    # sed wrong environment variables
    sed -i -e "s:mkdir -p \"/usr/local/${PN}-3.3.0/lib\":mkdir -p \"${D}/usr/local/${PN}-${PV}/lib\":" \
                        setenvironment.sh || die "bad sed"

    sed -i -e "s:export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH\:/usr/local/${PN}-3.3.0/lib\:\$SDEHOME/lib:export \ 
                        LD_LIBRARY_PATH=\$LD_LIBRARY_PATH\:${D}/usr/local/${PN}-${PV}/lib\:\$SDEHOME/lib:" \
                        setenvironment.sh || die "bad sed"

    source ./setenvironment.sh

    # patch makefiles to support sandboxing !
#    sed -i -e "s:INSTALL_DIR = \$(prefix)/nls:INSTALL_DIR = ${D}/\$(prefix)/nls:" Fdo/Unmanaged/Src/Message/Makefile.am || die "bad sed"

    # patch Utilities/OWS/Makefile.in
#    cd "${S}/Utilities/OWS/"
#    sed -i -e "s:\$(FDOTHIRDPARTY)/boost_1_32_0/bin/boost/libs/thread/build/libboost_thread.a/gcc/release/runtime-link-static/threading-multi/libboost_thread-gcc-mt-s-1_32.a::" Makefile.am || die "bad sed"
#    sed -i -e "s:\$(FDOTHIRDPARTY)/libcurl/lib/linux/libcurl.a:/usr/lib/libcurl.a:" Makefile.am || die "bad sed"
#    sed -i -e "s:\$(FDOTHIRDPARTY)/openssl/lib/linux/libssl.a:/usr/lib/libssl.a:" Makefile.am || die "bad sed"
#    sed -i -e "s:\$(FDOTHIRDPARTY)/openssl/lib/linux/libcrypto.a:/usr/lib/libcrypto.a:" Makefile.am || die "bad sed"

    # patch Utilities/SQLiteInterface/Makefile.in
#    cd "${S}/Utilities/SQLiteInterface/"
#    sed -i -e "s:-I\$(FDOTHIRDPARTY)/Sqlite3.1.5/Src:-I/usr/include:" Makefile.am || die "bad sed"
#    sed -i -e "s:-I\$(FDOTHIRDPARTY)/ZLib/src:-I/usr/include:" Makefile.am || die "bad sed"

    # patch Fdo/Unmanaged/Src/Fdo/Makefile.in
#    cd "${S}/Fdo/Unmanaged/Src/Fdo/"
#    sed -i -e "s:-I\$(FDOTHIRDPARTY)/apache/xml-xerces/c/src:-I/usr/include:" Makefile.am || die "bad sed"

    # patch Fdo/Unmanaged/Src/Common/Makefile.in
#    cd "${S}/Fdo/Unmanaged/Src/Common/"
#    sed -i -e "s:-I\$(FDOTHIRDPARTY)/apache/xml-xalan/c/src:-I/usr/include:" Makefile.am || die "bad sed"
#    sed -i -e "s:-I\$(FDOTHIRDPARTY)/apache/xml-xerces/c/src:-I/usr/include:" Makefile.am || die "bad sed"

    # patch Fdo/Unmanaged/Src/Makefile.in
#    cd "${S}/Fdo/Unmanaged/Src/"
#    sed -i -e "s:-I\$(FDOTHIRDPARTY)/apache/xml-xalan/c/src:-I/usr/include:" Makefile.am || die "bad sed"
#    sed -i -e "s:-I\$(FDOTHIRDPARTY)/apache/xml-xerces/c/src:-I/usr/include:" Makefile.am || die "bad sed"

    # patch Fdo/UnitTest/Makefile.in
#    cd "${S}/Fdo/UnitTest/"
#    sed -i -e "s:-I\$(FDOTHIRDPARTY)/linux/cppunit/include:-I/usr/include/cppunit:" Makefile.am || die
#    sed -i -e "s:\$(FDOTHIRDPARTY)/linux/cppunit/lib/libcppunit.a:-I/usr/lib/libcppunit.a:" Makefile.am || die

    # building thirdparty modules
    cd "${S}/Thirdparty/"
    ./Thirdparty.sh

    # autotooling
    cd "${S}"

    aclocal
    libtoolize --force
    automake --add-missing --copy
    autoconf

    # configure
    local myconf
    myconf=""

    econf ${myconf} || die "econf failed"

    # make
    emake || die "make failed"
}

src_install() {

    make DESTDIR=${D} install || die
}
