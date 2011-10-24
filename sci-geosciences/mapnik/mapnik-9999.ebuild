# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/mapnik/mapnik-0.7.1-r1.ebuild,v 1.8 2011/09/26 07:45:56 nerdboy Exp $

EAPI=3

SNAPSHOT="yes"

PYTHON_DEPEND="python? 2"
inherit git-2 eutils flag-o-matic python toolchain-funcs versionator

DESCRIPTION="A Free Toolkit for developing mapping applications."
HOMEPAGE="http://www.mapnik.org/"
EGIT_REPO_URI="git://github.com/mapnik/mapnik.git"
PATCHES=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="-doc cairo csv curl debug +gdal geos kismet oracle postgres python sqlite rasterlite test"

RDEPEND="dev-libs/boost
	dev-libs/icu
	dev-libs/libxml2:2
	media-fonts/dejavu
	media-libs/freetype:2
	virtual/jpeg
	media-libs/libpng
	media-libs/tiff
	sci-libs/proj
	cairo? (
		x11-libs/cairo
		dev-cpp/cairomm
		python? ( dev-python/pycairo )
	)
	curl? ( net-misc/curl )
	gdal? ( sci-libs/gdal )
	geos? ( sci-libs/geos )
	oracle? ( dev-db/oracle-instantclient-basic )
	postgres? (
		>=dev-db/postgresql-base-8.3
		>=dev-db/postgis-1.5.2
	)
	python? ( dev-libs/boost[python] )
    test? (
        dev-python/nose
    )
	rasterlite? ( sci-libs/rasterlite )
	sqlite? ( dev-db/sqlite:3 )"

DEPEND="${RDEPEND}
	doc? ( dev-python/epydoc )
	dev-util/scons"

S="${WORKDIR}/${PN}"

src_prepare() {
    if ( use oracle ) && [ -z "$ORACLE_HOME" ] ; then
        eerror "ORACLE_HOME variable is not set."
        eerror
        eerror "You must install Oracle >= 10g client for Linux in"
        eerror "order to compile mapnik with Oracle support."
        eerror
        eerror "Otherwise specify -oracle in your USE variable."
        eerror
        eerror "You can install Oracle instant client with"
        eerror "  emerge -av oracle-instantclient-basic"
        die
    fi

	sed -i \
		-e "s|/usr/local|/usr|g" \
		-e "s|Action(env\[config\]|Action('%s --help' % env\[config\]|" \
		SConstruct || die "sed 1 failed"

	sed -i \
		-e "s:mapniklibpath + '/fonts':'/usr/share/fonts/dejavu/':g" \
	    bindings/python/build.py || die "sed 2 failed"

	# TODO - check this... update for libpng 1.5 changes (see bug #)
	# epatch "${FILESDIR}"/${P}-libpng1.5.4.patch
}

src_configure() {
	EMAKEOPTS="SYSTEM_FONTS=/usr/share/fonts/dejavu"

	EMAKEOPTS="${EMAKEOPTS} INPUT_PLUGINS="
	use kismet      && EMAKEOPTS="${EMAKEOPTS}kismet,"
	use oracle      && EMAKEOPTS="${EMAKEOPTS}occi,"
	use postgres    && EMAKEOPTS="${EMAKEOPTS}postgis,"
	use gdal        && EMAKEOPTS="${EMAKEOPTS}gdal,ogr,"
	use geos        && EMAKEOPTS="${EMAKEOPTS}geos,"
	use sqlite      && EMAKEOPTS="${EMAKEOPTS}sqlite,"
	use rasterlite  && EMAKEOPTS="${EMAKEOPTS}rasterlite,"
	use curl        && EMAKEOPTS="${EMAKEOPTS}osm,"
	use csv         && EMAKEOPTS="${EMAKEOPTS}csv,"
	EMAKEOPTS="${EMAKEOPTS}shape,raster"

	use cairo  || EMAKEOPTS="${EMAKEOPTS} CAIRO=false"
	use python || EMAKEOPTS="${EMAKEOPTS} BINDINGS=none"
	use debug  && EMAKEOPTS="${EMAKEOPTS} DEBUG=yes"
	EMAKEOPTS="${EMAKEOPTS} DESTDIR=${D}"

    use oracle && EMAKEOPTS="${EMAKEOPTS} OCCI_INCLUDES = '${ORACLE_HOME}/include'"
    use oracle && EMAKEOPTS="${EMAKEOPTS} OCCI_LIBS = '${ORACLE_HOME}/lib'"

	use postgres && use sqlite && EMAKEOPTS="${EMAKEOPTS} PGSQL2SQLITE=yes"

	BOOST_PKG="$(best_version "dev-libs/boost")"
	BOOST_VER="$(get_version_component_range 1-2 "${BOOST_PKG/*boost-/}")"
	export BOOST_VERSION="$(replace_all_version_separators _ "${BOOST_VER}")"
	elog "${P} BOOST_VERSION is ${BOOST_VERSION}"
	export BOOST_INC="/usr/include/boost-${BOOST_VERSION}"
	elog "${P} BOOST_INC is ${BOOST_INC}"
	BOOST_LIBDIR_SCHEMA="$(get_libdir)/boost-${BOOST_VERSION}"
	export BOOST_LIB="/usr/${BOOST_LIBDIR_SCHEMA}"
	elog "${P} BOOST_LIB is ${BOOST_LIB}"

	# force older boost filesystem version until upstream migrates
	if version_is_at_least "1.46" "${BOOST_VER}"; then
		append-flags -DBOOST_FILESYSTEM_VERSION=2
	fi

	# Passing things doesn't seem to hit all the right paths; another
	# poster-child for just a bit too much complexity for its own good.
	# See bug #301674 for more info.
	sed -i -e "s|searchDir, LIBDIR_SCHEMA|searchDir, \'${BOOST_LIBDIR_SCHEMA}\'|" \
		-i -e "s|include/boost*|include/boost-${BOOST_VERSION}|" \
		SConstruct || die "sed boost paths failed..."

	# this seems to be the only way to force user-flags, since nothing
	# gets through the scons configure except the nuclear sed option.
	sed -i -e "s:\-O%s:${CXXFLAGS}:" \
		-i -e "s:env\['OPTIMIZATION'\]\,::" \
		SConstruct || die "sed 3 failed"
	sed -i -e "s:LINKFLAGS=linkflags:LINKFLAGS=linkflags + \" ${LDFLAGS}\":" \
		src/build.py || die "sed 4 failed"

	scons CC="$(tc-getCC)" CXX="$(tc-getCXX)" ${EMAKEOPTS} configure \
		|| die "scons configure failed"
}

src_compile() {
	# note passing CXXFLAGS to scons does *not* work
	scons CC="$(tc-getCC)" CXX="$(tc-getCXX)" \
		shared=1 || die "scons make failed"

	# this is known to depend on mod_python and should not have a
	# "die" after the epydoc script (see bug #370575)
	if use doc; then
		export PYTHONPATH="${S}/bindings/python:$(python_get_sitedir)"
		cd docs/epydoc_config
		./build_epydoc.sh
		cd -
	fi
}

src_install() {
	scons DESTDIR="${D}" install || die "scons install failed"

	if use python ; then
		fperms 0755 "$(python_get_sitedir)"/mapnik/paths.py
		dobin utils/stats/mapdef_stats.py
		insinto /usr/share/doc/${PF}/examples
		doins utils/ogcserver/*
	fi

	dodoc AUTHORS CHANGELOG README || die
	use doc && { dohtml -r docs/api_docs/python/* || die "API doc install failed"; }
}

pkg_postinst() {
	elog ""
	elog "See the home page or wiki (http://trac.mapnik.org/) for more info"
	elog "or the installed examples for the default mapnik ogcserver config."
	elog ""
}
