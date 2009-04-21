# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils fdo-mime rpm

OOMILESTONE="2"
OODATE="20080429"
OOVER="3.0.0"
OOBUILD="9301"
OOARCH="i586"

DESCRIPTION="OpenOffice.org 3.0 devel snapshot"
HOMEPAGE=""
OOPKG="OOo_3.0.0beta_${OODATE}_LinuxIntel_install_en-US.tar.gz"
ICONPKG="74029-OpenOffice_Dock_Icons_v2_by_ducatart.zip"
#SRC_URI="http://ftp.stardiv.de/pub/OpenOffice.org/developer/3.0.0beta/$OOPKG
SRC_URI="mirror://openoffice/developer/3.0.0beta/$OOPKG
http://gnome-look.org/CONTENT/content-files/$ICONPKG"

#RESTRICT="nomirror"

LICENSE="LGPL-3.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="kde gnome"

RDEPEND="!app-office/openoffice
        x11-libs/libXaw
        sys-libs/glibc
        >=dev-lang/perl-5.0
        app-arch/zip
        app-arch/unzip
        >=media-libs/freetype-2.1.10-r2
        java? ( !amd64? ( >=virtual/jre-1.4 )
                amd64? ( app-emulation/emul-linux-x86-java ) )
        amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.0 )"

#        linguas_ja? ( >=media-fonts/kochi-substitute-20030809-r3 )
#        linguas_zh_CN? ( >=media-fonts/arphicfonts-0.1-r2 )
#        linguas_zh_TW? ( >=media-fonts/arphicfonts-0.1-r2 )"

DEPEND="${RDEPEND}
        sys-apps/findutils"

PROVIDE="virtual/ooo"
RESTRICT="strip"

S="$WORKDIR/BEA300_m${OOMILESTONE}_native_packed-2_en-US.$OOBUILD"

OO_PREFIX="openoffice.org3"
OOBASE_PREFIX="ooobasis3.0"
OOBASE_RPMS="base
calc
core01
core02
core03
core04
core05
core06
core07
core08
draw
emailmerge
en-US
en-US-base
en-US-calc
en-US-draw
en-US-help
en-US-impress
en-US-math
en-US-onlineupd
en-US-res
en-US-writer
graphicfilter
headless
images
impress
javafilter
math
onlineupdate
ooofonts
ooolinguistic
pyuno
testtool
writer
xsltfilter"

OO_RPMS="base
calc
draw
impress
math
writer"

ooodev_rpmunpack() {
	rpm_unpack "$S/RPMS/$1.rpm" || die
	rm "$S/RPMS/$1.rpm"
}

ooodev_unpack()
{
	einfo "unpacking rpm component '$1'"
	ooodev_rpmunpack "$1-$OOVER-$OOBUILD.$OOARCH"
}

src_unpack()
{
	unpack "$OOPKG" || die "could not unpack tarball"
	mkdir -p "$WORKDIR/ooicons"
	cd "$WORKDIR/ooicons"
	unpack "$ICONPKG"
	rm -f "$S/RPMS/"jre-*.rpm
}

src_install()
{
	cd $D

	for r in $OOBASE_RPMS; do		
		ooodev_unpack $OOBASE_PREFIX-$r
	done

	for r in $OO_RPMS; do
		ooodev_unpack $OO_PREFIX-$r
	done

	ooodev_rpmunpack openoffice.org-ure-1.4.0-$OOBUILD.$OOARCH
	ooodev_rpmunpack $OO_PREFIX-3.0.0-$OOBUILD.$OOARCH
	ooodev_rpmunpack $OO_PREFIX-en-US-3.0.0-$OOBUILD.$OOARCH

	use kde && ooodev_unpack $OOBASE_PREFIX-kde-integration
	use gnome && ooodev_unpack $OOBASE_PREFIX-gnome-integration

	mkdir -p "$D/usr/share/applications"
	cp "$D/opt/openoffice.org3/share/xdg"/*.desktop "$D/usr/share/applications"

	local ooexec="$OO_PREFIX.0"

	mkdir -p "$D/usr/bin"
	echo "#!/bin/sh
exec /opt/openoffice.org3/program/soffice \"\$@\"
" > "$D/usr/bin/$ooexec"
	chmod a+x "$D/usr/bin/$ooexec"

	#using external icons because I couldn't find the real ones
	cd "$WORKDIR/ooicons"
	rm -f *preview.png
	for i in base calc draw impress math writer; do
		mv "oo_${i}_v2.png" openofficeorg30-$i.png
	done
	insinto /usr/share/icons/hicolor/128x128/apps
	doins *.png
}

src_compile()
{
:;
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
