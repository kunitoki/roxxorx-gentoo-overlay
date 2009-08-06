# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit autotools eutils flag-o-matic subversion wxwidgets

ESVN_REPO_URI="svn://svn.berlios.de/codeblocks/trunk"
ESVN_CO_DIR="${PORTAGE_ACTUAL_DISTDIR-${DISTDIR}}"/svn-src/${P/-svn}/"${ESVN_REPO_URI##*/}"
ESVN_PROJECT="${P}"

WX_GTK_VER="2.8"

DESCRIPTION="free cross-platform C/C++ IDE"
HOMEPAGE="http://www.codeblocks.org/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="contrib static vanilla debug"

RDEPEND="=x11-libs/wxGTK-${WX_GTK_VER}*
x11-libs/gtk+
!dev-util/codeblocks
!dev-util/codeblocks-cvs"

DEPEND="${RDEPEND}
>=sys-devel/autoconf-2.5.0
>=sys-devel/automake-1.7
>=sys-devel/libtool-1.4
app-arch/zip"

src_unpack() {
	subversion_src_unpack
}

src_prepare() {
	cd ${S}
# Lets make the autorevision work. So we need ".svn" directories for build
einfo "Syncing ${ESVN_STORE_DIR}/${ESVN_PROJECT}/${ESVN_REPO_URI##*/}/ into ${S}"
	rsync -a "${ESVN_STORE_DIR}/${ESVN_PROJECT}/${ESVN_REPO_URI##*/}/" "${S}" || die "${ESVN}: can't export to ${S}."
	sh update_revision.sh || die "\"update_revision.sh\" failed..."
einfo "Changing properties ..." && \
	edos2unix ${S}/{bootstrap,src/update} && \
	chmod a+rx ${S}/{bootstrap,src/update} && \
	eautoreconf || die "Died in action: eautoreconf..."
}

src_configure() {
# C::B is picky on CXXFLAG -fomit-frame-pointer
# (project-wizard crash, instability ...)
	filter-flags -fomit-frame-pointer
	append-flags -fno-strict-aliasing

	local myconf=""

	if use contrib; then
		myconf="${myconf} --with-contrib-plugins=all"
	fi
	econf --with-wx-config="${WX_CONFIG}" --enable-dependency-tracking \
		$(use_enable debug) \
		$(use_enable static) \
		${myconf} || die "Died in action: econf ..."
}

src_compile() {
	emake clean-zipfiles || die "\"make clean-zipfiles\" failed..."
	emake || die "Died in action: make ..."
}

src_install() {
	emake DESTDIR="${D}" install || die "Died in action: make install ... "

# Projectwizard needs a all-in-one-directory for wx envvar
# (finding wxWidgets files/headers). Must be a dir with include
# and lib under it, so we create symlinks:
	local linkdir=${D}/usr/share/wx
	local wxlibdir

	mkdir -p ${linkdir}

	if [ -L ${linkdir}/include ]; then
		rm -f ${linkdir}/include
	fi
	einfo "Creating wxGTK \"include\" symlink in ${linkdir}..." && \
		ln -sf /usr/include/wx-${WX_GTK_VER} ${linkdir}/include && \
		echo " done." || die "Linking wxGTK includes failed"
	wxlibdir="/usr/lib/wx/include/gtk2-unicode-release-${WX_GTK_VER}"

	if [ -L ${linkdir}/lib ]; then
		rm -f ${linkdir}/lib
	fi
	einfo "Creating wxGTK \"lib\" symlink in ${linkdir}..." && \
		ln -sf ${wxlibdir} ${linkdir}/lib && \
		echo " done." || die "Linking wxGTK lib failed"
}

pkg_postinst() {
echo
ewarn "IMPORTANT:"
ewarn "This is an unofficial ebuild for CODE::BLOCKS IDE."
ewarn "If you encounter any problems, do NOT file bugs to gentoo"
ewarn "bugzilla. Instead, post into this ebuild's topic on the"
ewarn "Gentoo Forums in the UNSUPPORTED SOFTWARE section!"
ewarn "link:"
ewarn "http://forums.gentoo.org/viewtopic-t-588089.html"
echo
echo
einfo "PLEASE READ:"
einfo "When using the new ProjectWizard to create a wxWidgets project"
einfo "you will be prompted for the wxWidgets' location."
einfo "This ebuild has set up (symlinks) a conformant directory in:"
einfo "\"/usr/share/wx\""
einfo "Please select this directory as wxWidgets' location."
echo
echo
}
