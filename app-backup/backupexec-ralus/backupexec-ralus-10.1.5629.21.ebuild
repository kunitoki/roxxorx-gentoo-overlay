# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils rpm

MY_PV="10.1.5629.3"

GUIDE_DOC_ID="279401"
GUIDE_FETCH_URI="http://seer.support.veritas.com/docs/${GUIDE_DOC_ID}.htm"

RALUS_Q_ID="Q180968"
RALUS_DOC_ID="279329"
RALUS_FILE="${RALUS_Q_ID}.BE.RALUS.${MY_PV}.tar_${RALUS_DOC_ID}.gz"
RALUS_FETCH_URI="http://seer.support.veritas.com/docs/${RALUS_DOC_ID}.htm"

PATCH_DOC_ID="282308"
PATCH_FILE="ralus5629HF21_${PATCH_DOC_ID}.zip"
PATCH_FETCH_URI="http://seer.support.veritas.com/docs/${PATCH_DOC_ID}.htm"

VRTSRALUS_FILE="VRTSralus-10.00.5629-0.i386.rpm"
VRTSVXMSA_FILE="VRTSvxmsa-4.2.1-211.i386.rpm"

LINUX_PATCH_FILE="ralus5629HF21-Linux.tar"
LINUX_HOTFIX_FILE="HF21-Linux.tar"

DESCRIPTION="Symantec Backup Exec Remote Agent for Linux and Unix Servers (RALUS)"
HOMEPAGE="http://www.symantec.com/backupexec/"
SRC_URI="${RALUS_FILE} ${PATCH_FILE}"
LICENSE="VERITAS-EUSLA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="fetch mirror"
DEPEND="app-arch/unzip"
RDEPEND="amd64? ( app-emulation/emul-linux-x86-compat )
    x86? ( sys-libs/lib-compat )"
S="${WORKDIR}"

pkg_nofetch() {
    einfo "Please download ${RALUS_FILE} from:"
    einfo "${RALUS_FETCH_URI}"
    einfo "and move it to ${DISTDIR}"
    einfo
    einfo "Please download ${PATCH_FILE} from:"
    einfo "${PATCH_FETCH_URI}"
    einfo "and move it to ${DISTDIR}"
}

src_unpack() {
    # unpack the package
    for i in ${VRTSRALUS_FILE} ${VRTSVXMSA_FILE}
    do
        einfo "Extracting: ${i}"
        tar -xzf "${DISTDIR}/${RALUS_FILE}" "linux/pkgs/linux/${i}" --strip-components 3 \
            || die "Extracting ${i} failed"
        rpm_unpack "${WORKDIR}/${i}" || die "Extracting ${i} failed"
    done

    # unpack the hotfix
    einfo "Extracting: ${LINUX_HOTFIX_FILE}"
    unzip -pqq "${DISTDIR}/${PATCH_FILE}" "${LINUX_PATCH_FILE}" | tar -xO "${LINUX_HOTFIX_FILE}" | tar -x \
        || die "Extracting ${LINUX_HOTFIX_FILE} failed"

    # merge the hotfix files
    mv -f "${WORKDIR}/beremote" "${WORKDIR}/opt/VRTSralus/bin"
    mv -f "${WORKDIR}/libndmpcomm.so" "${WORKDIR}/opt/VRTSralus/bin"
    mv -f "${WORKDIR}/ralus.ver" "${WORKDIR}/var/VRTSralus"

    # delete the original init script
    rm -f "${WORKDIR}/opt/VRTSralus/bin/VRTSralus.init"
}

src_install() {
    # install the package files to /etc
    dodir /etc/VRTSralus
    chmod -R 600 "${S}/etc"
    cp -aR "${S}/etc/VRTSralus" "${D}/etc" || die "Install failed"

    # install the package files to /opt
    dodir /opt/VRTS
    dodir /opt/VRTSralus
    dodir /opt/VRTSvxms
    chmod -R 500 "${S}/opt"
    cp -aR "${S}/opt/VRTS" "${D}/opt" || die "Install failed"
    cp -aR "${S}/opt/VRTSralus" "${D}/opt" || die "Install failed"
    cp -aR "${S}/opt/VRTSvxms" "${D}/opt" || die "Install failed"

    # install the package files to /var
    dodir /var/VRTSralus
    chmod -R 600 "${S}/var"
    cp -aR "${S}/var/VRTSralus" "${D}/var" || die "Install failed"

    # install the init.d file
    newinitd "${FILESDIR}/backupexec-ralus.initd" backupexec-ralus

    # install the conf.d file
    newconfd "${FILESDIR}/backupexec-ralus.confd" backupexec-ralus
}

pkg_preinst() {
    # add the beoper group
    enewgroup beoper
}

pkg_postinst() {
    elog
    elog "Configuration of /etc/VRTSralus/ralus.cfg is necessary for RALUS to function."
    elog "For more details consult page 808 of the Symantec Backup Exec 10d for Windows"
    elog "Servers Administrator's Guide."
    elog "${GUIDE_FETCH_URI}"
    elog
    elog "RALUS requires that a user be added to the beoper group to function. The"
    elog "user must have permission to access all the files selected for backup."
    elog "# gpasswd -a <user> beoper"
    elog
    elog "RALUS uses port 10000 by default. If this port is in use (e.g. Webmin)"
    elog "edit /etc/services and add the ndmp service with an available port."
    elog "ndmp <port>/tcp"
    elog
    elog "To start RALUS:"
    elog "# /etc/init.d/backupexec-ralus start"
    elog
    elog "To start RALUS at boot:"
    elog "# rc-update add backupexec-ralus default"
    elog
}

