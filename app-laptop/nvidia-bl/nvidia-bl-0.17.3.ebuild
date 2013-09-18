# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virtualbox-modules/virtualbox-modules-3.2.12.ebuild,v 1.4 2011/02/03 07:44:43 tomka Exp $

EAPI=2

inherit eutils linux-info linux-mod

MY_P=nvidia-bl-dkms_${PV}~natty
MY_PD=nvidia-bl-dkms-${PV}
MY_MODULENAME=nvidia_bl

DESCRIPTION="Support for backlight control of nvidia cards on some laptops"
HOMEPAGE="https://launchpad.net/~mactel-support/"
SRC_URI="https://launchpad.net/~mactel-support/+archive/ppa/+files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=""

S=${WORKDIR}/${MY_PD}/usr/src/dkms_source_tree/

MODULE_NAMES="nvidia_bl(video:${S})"

pkg_setup() {
	linux-mod_pkg_setup
	if kernel_is lt 2 6 29; then
		die "Your kernel is too old."
	fi
}

src_prepare() {
    epatch "${FILESDIR}/${PV}-gt330m.patch"

    cp "${FILESDIR}/${PV}-Makefile" "${S}/Makefile"

    sed -ie "s/__devinitconst//g" "${S}/nvidia_bl.c"

    if use debug; then
        true
    else
        sed -ie "s/DEBUG = y/#DEBUG = y/" "${S}/Makefile" || die "failed patching Makefile"
    fi
}

src_compile() {
    set_arch_to_kernel
    emake \
        LINUXDIR="${KERNEL_DIR}" \
        || die "Compiling kernel modules failed"
}

src_install() {
    linux-mod_src_install

    insinto /etc/modprobe.d
    doins ${FILESDIR}/${MY_MODULENAME}.conf || die "doins failed"
}

pkg_postinst() {
    linux-mod_pkg_postinst

    elog "WARNING: Do not forget to set the default max brigthness"
    elog "option when loading the kernel module, or you will be"
    elog "experiencing your backlight to reset to a very dark default"
    elog "making you unable to see anything !"
    elog ""
    elog "Look into /etc/modprobe.d/${MY_MODULENAME}.conf to change"
    elog "your preferred max level for your card"
    elog ""
    if has_version sys-apps/openrc; then
        elog "Please add \"nvidia_bl\" to:"
        elog ""
        elog "/etc/conf.d/modules"
        elog ""
        elog "And set the default option:"
        elog ""
        elog "echo \"module_nvidia_bl_args=\\\"max_level=131072\\\"\" \\"
        elog "  >> \"/etc/conf.d/modules\""
    else
        elog "Add the module and set the default option:"
        elog ""
        elog "echo \"nvidia_bl max_level=131072\" \\"
        elog "  >> /etc/modules.autoload.d/kernel-${KV_MAJOR}.${KV_MINOR}"
    fi
    elog ""
}
