DESCRIPTON = "Husqvarna toplayer sudo overlay"

LICENSE = "CLOSED"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://gardena \
"

S = "${WORKDIR}"

do_install:append() {
    mkdir -p ${D}${sysconfdir}/sudoers.d
    install -m 0440 ${WORKDIR}/gardena ${D}${sysconfdir}/sudoers.d/gardena
}

CONFFILES:${PN} += "${sysconfdir}/sudoers.d/gardena"
