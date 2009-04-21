# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/mikachan-font-ttf/mikachan-font-ttf-8.9-r1.ebuild,v 1.16 2007/02/17 13:41:46 vapier Exp $

inherit font

MY_PN="comicsfonts"

DESCRIPTION="Blambot Comics TrueType fonts"
HOMEPAGE="http://www.blambot.com"
SRC_URI="http://www.blambot.com/fonts/10centsovietbb.zip
		http://www.blambot.com/fonts/androidnation.zip
		http://www.blambot.com/fonts/acmesag.zip
        http://www.blambot.com/fonts/animeace2bb_tt.zip
		http://www.blambot.com/fonts/arcanum.zip
		http://www.blambot.com/fonts/autodestructbb_tt.zip
		http://www.blambot.com/fonts/bottlerocketbb.zip
		http://www.blambot.com/fonts/creativeblockbb.zip
		http://www.blambot.com/fonts/crimefighterbb.zip
		http://www.blambot.com/fonts/destructobeambb_tt.zip
		http://www.blambot.com/fonts/digitalstrip.zip
		http://www.blambot.com/fonts/evilgeniusbb_tt.zip
		http://www.blambot.com/fonts/fanboyhc.zip
		http://www.blambot.com/fonts/indiestarbb_tt.zip
		http://www.blambot.com/fonts/mangatemple.zip
		http://www.blambot.com/fonts/sanitariumbb_tt.zip
		http://www.blambot.com/fonts/smackattackbb_tt.zip
		http://www.blambot.com/fonts/spacepontiff.zip
		http://www.blambot.com/fonts/straightjacketbb_tt.zip
		http://www.blambot.com/fonts/sundaycomicsbb_tt.zip
		http://www.blambot.com/fonts/weblettererbb.zip
		http://www.blambot.com/fonts/badaboombb.zip
		http://www.blambot.com/fonts/antigravbb_tt.zip
		http://www.blambot.com/fonts/atlandsketchesbb_tt.zip
		http://www.blambot.com/fonts/battlelines.zip
		http://www.blambot.com/fonts/bettynoir.zip
		http://www.blambot.com/fonts/bigblokebb.zip
		http://www.blambot.com/fonts/blamdudebb.zip
		http://www.blambot.com/fonts/chatteryteeth.zip
		http://www.blambot.com/fonts/coah.zip
		http://www.blambot.com/fonts/detectivesinc.zip
		http://www.blambot.com/fonts/fofbb.zip
		http://www.blambot.com/fonts/firefightbb_tt.zip
		http://www.blambot.com/fonts/gorillamilkshake.zip
		http://www.blambot.com/fonts/gunheadchick.zip
		http://www.blambot.com/fonts/lowriderbb.zip
		http://www.blambot.com/fonts/newsflashbb_tt.zip
		http://www.blambot.com/fonts/orangefizz.zip"

LICENSE="free"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

FONT_S="${WORKDIR}"
FONT_SUFFIX="ttf"

# Only installs fonts
RESTRICT="strip binchecks"

src_install() {

    cd "${WORKDIR}"

	for x in `find * -type f`;
	do
		# Translate Caps to Small letters
		y=$(echo $x | tr '[A-Z]' '[a-z]');
		if [ "$x" != "$y" ]; then
    		mv $x $y;
		fi
	done

    insinto /usr/share/fonts/${MY_PN}
    doins *.ttf

    font_xfont_config
    font_xft_config
}

