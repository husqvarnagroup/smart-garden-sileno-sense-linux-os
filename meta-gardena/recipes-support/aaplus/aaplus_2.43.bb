DESRIPTION = "A class framework for Computational Astronomy"

LICENSE = "aaplus"
NO_GENERIC_LICENSE[aaplus] = "AA+.h"
LIC_FILES_CHKSUM = "file://AA+.h;beginline=6;endline=17;md5=22de65e94c91601169ea374c022c41c9"

SRC_URI = "http://www.naughter.com/download/aaplus_v2.43.zip"

SRC_URI[md5sum] = "b13bbb0defa656129b79444220539d93"
SRC_URI[sha256sum] = "dc24f76dca8796437eb21893dcec9f79c3ec78b335e4bf0ac7d84ff7fec0630b"

inherit cmake

S = "${WORKDIR}"

do_install:append() {
    install -m 0700 -d ${D}${includedir}/aaplus/
    cp -f ${S}/AARiseTransitSet2.h ${D}${includedir}/aaplus/
    cp -f ${S}/AADate.h ${D}${includedir}/aaplus/
    cp -f ${S}/AA2DCoordinate.h ${D}${includedir}/aaplus/
    cp -f ${S}/AADefines.h ${D}${includedir}/aaplus/

    cp -f ${S}/build/lib/libaaplus.so ${D}${libdir}/libaaplus.so.2.43
    ln -sf -r ${D}${libdir}/libaaplus.so.2.43 ${D}${libdir}/libaaplus.so
}

