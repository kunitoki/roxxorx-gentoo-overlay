# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="NVIDIA CUDA Toolkit"
HOMEPAGE="http://developer.nvidia.com/cuda"

NVIDIA_FILE_PREFIX="NVIDIA_CUDA_Toolkit_${PV}_Suse10.2_"
SRC_URI="amd64? (
			http://developer.download.nvidia.com/compute/cuda/1_1/Linux/toolkits/${NVIDIA_FILE_PREFIX}x86_64.run
		)
		x86? (
			http://developer.download.nvidia.com/compute/cuda/1_1/Linux/toolkits/${NVIDIA_FILE_PREFIX}x86.run
		)"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/perl" # perl for install-linux.pl
RDEPEND=""

RESTRICT="strip"

pkg_setup() {
	NVIDIA_FILE=${NVIDIA_FILE_PREFIX}x86.run
	use amd64 && NVIDIA_FILE=${NVIDIA_FILE_PREFIX}x86_64.run
}

src_unpack()
{
	unpack_makeself ${NVIDIA_FILENAME}
}

src_install()
{
	mkdir -p ${D}/opt/cuda
	${WORKDIR}/install-linux.pl --prefix=${D}/opt/cuda
	echo -e "PATH=/opt/cuda/bin\nLDPATH=/opt/cuda/lib" > cuda.envd
	newenvd cuda.envd 99cuda
}

