# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils toolchain-funcs

DESCRIPTION="Vodafone Mobile Connect Card driver for Linux is a GPRS/UMTS/HSDPA device manager written in Python"
HOMEPAGE="https://forge.vodafonebetavine.net/projects/vodafonemobilec/"
SRC_URI="https://forge.betavine.net/frs/download.php/267/${PN}-connect-card-driver-for-linux-${PV}.beta3.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-wireless/bluez-gnome
        sys-apps/hal
        dev-util/glade
        net-dialup/wvdial
        x11-libs/gksu
        sys-apps/lsb-release
        dev-python/dbus-python
        >=dev-python/twisted-2.5.0
        >=dev-python/twisted-conch-0.8.0
        dev-python/pyserial
        dev-python/pyinotify
        dev-python/pytz
        dev-python/gnome-python
        dev-python/gnome-python-extras
        >=dev-python/setuptools-0.6_rc6
        >=dev-python/pysqlite-2.3.5"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-connect-card-driver-for-linux-${PV}.beta3"

src_unpack() {
    unpack ${A}
    cd "${S}"
}

src_install() {
    
    python setup.py install --root ${D}

    cp "${S}"/resources/extra/95VMC-up "${D}"/etc/ppp/ip-up.d
    cp "${S}"/resources/extra/95VMC-down "${D}"/etc/ppp/ip-down.d

    chown :dialout "${D}"/etc/ppp/peers
    chmod g+rw "${D}"/etc/ppp/peers
    chown :dialout "${D}"/etc/ppp/*-secrets
    chmod g+rw "${D}"/etc/ppp/*-secrets

    dodoc INSTALL README     
}
