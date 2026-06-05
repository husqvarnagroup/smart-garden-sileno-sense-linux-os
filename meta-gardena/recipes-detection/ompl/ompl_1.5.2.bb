DESCRIPTION = "The Open Motion Planning Library"
HOMEPAGE = "https://github.com/ompl/ompl"

LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://LICENSE;md5=923f436234988118e9a042c42a64323c"

FILESEXTRAPATHS:prepend := "${THISDIR}/patches:"

SRC_URI[sha256sum] = "db1665dd2163697437ef155668fdde6101109e064a2d1a04148e45b3747d5f98"
SRC_URI += "https://github.com/ompl/ompl/archive/1.5.2.tar.gz \
           "

DEPENDS += "libeigen boost"

inherit cmake

EXTRA_OECMAKE += " -DOMPL_BUILD_DEMOS=OFF \
                   -DOMPL_VERSIONED_INSTALL=OFF \
                 "

INSANE_SKIP:${PN} += "useless-rpaths"

do_install:append() {
    rm -rf ${D}/usr/bin
    rm -rf ${D}/usr/share/ompl/demos
    rm -rf ${D}/usr/share/ament_index
    rm -rf ${D}/usr/share/ompl/demos
    rm -rf ${D}/usr/bin
}
