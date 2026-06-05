FILESEXTRAPATHS:prepend := "${THISDIR}/patches:"

SRC_URI += "file://extensions.patch \
            file://jpeg.patch \
           "

do_install:append() {
    install -m 0644 ${S}/include/NvBuffer.h ${D}${includedir}/
    install -m 0644 ${S}/include/NvJpegEncoder.h ${D}${includedir}/
    install -m 0644 ${S}/include/NvElement.h ${D}${includedir}/
    install -m 0644 ${S}/include/NvElementProfiler.h ${D}${includedir}/
    install -m 0644 ${S}/include/NvVideoConverter.h ${D}${includedir}/
    install -m 0644 ${S}/include/NvVideoEncoder.h ${D}${includedir}/
    install -m 0644 ${S}/include/NvV4l2Element.h ${D}${includedir}/
    install -m 0644 ${S}/include/NvV4l2ElementPlane.h ${D}${includedir}/
    install -m 0644 ${S}/include/NvLogging.h ${D}${includedir}/
    install -m 0644 ${S}/include/v4l2_nv_extensions.h ${D}${includedir}/
}

