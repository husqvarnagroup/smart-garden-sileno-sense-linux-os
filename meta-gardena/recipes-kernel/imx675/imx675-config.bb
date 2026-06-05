LICENSE = "CLOSED"
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = "file://imx675.conf"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/modprobe.d
    install -m 0644 ${WORKDIR}/imx675.conf ${D}${sysconfdir}/modprobe.d/
}

FILES:${PN} += "${sysconfdir}/modprobe.d/imx675.conf"
