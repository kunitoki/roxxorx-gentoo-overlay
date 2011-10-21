# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

PHP_EXT_NAME="mapi"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

ZARAFA_URL="http://www.zarafa.com/?q=en/download-community"
ZARAFA_PACKAGE="${P}.tar.gz"

inherit eutils php-ext-base-r1

DESCRIPTION="Open Source Groupware Solution"
HOMEPAGE="http://zarafa.com/"
SRC_URI="${ZARAFA_PACKAGE}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="fetch"
IUSE="debug ldap logrotate static"

RDEPEND="=dev-libs/libical-0.23
	=dev-cpp/libvmime-0.7.1
	>=dev-lang/php-5.2.0
	dev-db/mysql
	dev-libs/libxml2
	dev-libs/openssl
	net-misc/curl
	sys-libs/e2fsprogs-libs
	sys-libs/zlib
	ldap? ( net-nds/openldap )
	logrotate? ( app-admin/logrotate )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_nofetch() {
	einfo "Please download ${ZARAFA_PACKAGE} from:"
	einfo ${ZARAFA_URL}
	einfo "and move it to ${DISTDIR}"
}

src_compile() {
	econf \
		--enable-oss \
		--disable-perl \
		--disable-testtools \
		--with-userscript-prefix=/etc/zarafa/userscripts \
		--with-quotatemplate-prefix=/etc/zarafa/quotamails \
		$(use_enable static) \
		$(use_enable debug)
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	php-ext-base-r1_src_install

	if use logrotate; then
		insinto /etc/logrotate.d
		newins "${FILESDIR}"/zarafa.logrotate zarafa || die "Failed to install logrotate"
	fi

	insinto /etc/zarafa
	doins "${S}"/installer/linux/*.cfg || die "Failed to install config files"

	dodir /var/log/zarafa
	keepdir /var/log/zarafa

	newinitd ${FILESDIR}/zarafa-gateway.rc6 zarafa-gateway
	newinitd ${FILESDIR}/zarafa-ical.rc6 zarafa-ical
	newinitd ${FILESDIR}/zarafa-licensed.rc6 zarafa-licensed
	newinitd ${FILESDIR}/zarafa-monitor.rc6 zarafa-monitor
	newinitd ${FILESDIR}/zarafa-server.rc6 zarafa-server
	newinitd ${FILESDIR}/zarafa-spooler.rc6 zarafa-spooler
}
