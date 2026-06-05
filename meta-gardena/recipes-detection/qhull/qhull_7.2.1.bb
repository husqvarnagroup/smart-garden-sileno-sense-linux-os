DESCRIPTION = "Qhull"
HOMEPAGE = "https://github.com/qhull/qhull"

LICENSE = "qhull"
NO_GENERIC_LICENSE[qhull] = "COPYING.txt"
LIC_FILES_CHKSUM = "file://COPYING.txt;md5=6cf68697da2f499f1207c84dc319b727"

FILESEXTRAPATHS:prepend := "${THISDIR}/patches:"

SRC_URI = "https://github.com/qhull/qhull/archive/v${PV}.tar.gz \
           "
SRC_URI[md5sum] = "4f912bde6cf6540395dfeb9172f70101"
SRC_URI[sha256sum] = "6fc251e0b75467e00943bfb7191e986fce0e1f8f6f0251f9c6ce5a843821ea78"

S = "${WORKDIR}/qhull-${PV}"

#DEPENDS += "libeigen"

inherit cmake

EXTRA_OECMAKE += "  -DBUILD_SHARED_LIBS=ON \
                    -DBUILD_TESTING=OFF \
                    -DBUILD_APPLICATIONS=OFF \
                 "

INSANE_SKIP:${PN} += "useless-rpaths"

do_install:append() {


}
