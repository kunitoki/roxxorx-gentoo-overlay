# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/httping/httping-1.2.5.ebuild,v 1.1 2008/01/27 19:11:27 cedk Exp $

inherit eutils

DESCRIPTION="Web application framework for fast and efficient scripting and serving of your websites"
HOMEPAGE="http://dev.helma.org/"
SRC_URI="http://adele.helma.org/download/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="doc"

# or it depends on JDK ?
DEPEND="dev-java/java-config
		virtual/jre"
RDEPEND="${DEPEND}"

BASE="/usr/local"
BASEDIR=${BASE}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# sed conf in etc
	sed -i -e "s:JAVA_HOME=/usr/lib/j2sdk1.5-sun::" ${S}/scripts/${PN}.conf || die "Bad sed"
	sed -i -e "s:JAVA_BIN=\$JAVA_HOME/bin/java::" ${S}/scripts/${PN}.conf || die "Bad sed"
	sed -i -e "s:HELMA_INSTALL=/usr/local/helma/helma-1.6.x:HELMA_INSTALL=${BASE}/${PN}:" ${S}/scripts/${PN}.conf || die "Bad sed"
	sed -i -e "s:HELMA_LOG=\$HELMA_HOME/log/helma-out.log:HELMA_LOG=/var/log/helma/helma-service.log:" ${S}/scripts/${PN}.conf || die "Bad sed"
	sed -i -e "s:# logDir = console:logDir = /var/log/helma/:" ${S}/server.properties || die "Bad sed"

	echo "" >> ${S}/server.properties
	echo "# Specify a new home for helma internal database" >> ${S}/server.properties
	echo "dbHome = /var/run/helma" >> ${S}/server.properties
}

src_install() {
    dodir /etc
	dodir /etc/init.d

	# copy init.d scripts
    cp ${S}/scripts/${PN}.conf "${D}"/etc/
	cp "${FILESDIR}"/${P}-initscript.sh "${D}"/etc/init.d/${PN}
    chmod 700 "${D}"/etc/init.d/${PN}

	# copy stuff over to basedir
	dodir ${BASE}
    dodir ${BASEDIR}

	rm -Rf ${S}/scripts
	if ! use doc ; then
		rm -Rf ${S}/docs
	fi
    cp -R ${S}/* "${D}"/${BASEDIR}

	# create directory for logging
	dodir /var/log/helma
	dodir /var/run/helma
}

pkg_postinst() {
	# add default helma user
	enewgroup ${PN} || die "Unable to create HELMA group !"
	enewuser ${PN} -1 -1 /dev/null ${PN} || die "Unable to create HELMA user !"
	usermod -a -G helma helma

	# change permission to log directory
	chown -R helma:helma /var/log/helma
	chown -R helma:helma /var/run/helma
}
