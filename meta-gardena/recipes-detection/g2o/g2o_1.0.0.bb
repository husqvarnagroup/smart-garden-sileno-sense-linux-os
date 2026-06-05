DESCRIPTION = "g2o: A General Framework for Graph Optimization"
HOMEPAGE = "https://github.com/RainerKuemmerle/g2o"

LICENSE = "BSD-1-Clause"
LIC_FILES_CHKSUM = "file://doc/license-bsd.txt;md5=e13cdf725d5222ff128c0173bb15c328"

FILESEXTRAPATHS:prepend := "${THISDIR}/patches:"

SRC_URI += "git://github.com/RainerKuemmerle/g2o.git;protocol=https;branch=master; \
           file://0001-yocto-version-fixes.patch \
           "

SRCREV = "26f775d144f3b09bc072b90b903631036a1e4107"

S = "${WORKDIR}/git"

DEPENDS += "libeigen"

inherit cmake

EXTRA_OECMAKE += "  -DG2O_USE_OPENGL=OFF \
                    -DG2O_BUILD_APPS=OFF \
                    -DG2O_BUILD_EXAMPLES=OFF \
                    -DCMAKE_G2O_HAS_SSE2=OFF \
                    -DCMAKE_G2O_HAS_SSE3=OFF \
                    -DCMAKE_G2O_HAS_SSE4_1=OFF \
                    -DCMAKE_G2O_HAS_SSE4_2=OFF \
                    -DCMAKE_G2O_HAS_SSE4_A=OFF \
                 "

do_install:append() {


}
