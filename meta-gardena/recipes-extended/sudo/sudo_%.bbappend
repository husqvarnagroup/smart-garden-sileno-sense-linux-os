FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://gardena-nvpmodel \
    file://gardena-generic-resources \
    file://gardena \
    file://advanced \
"

do_install:append() {
    install -m 0440 ${WORKDIR}/gardena-nvpmodel ${D}${sysconfdir}/sudoers.d/gardena-nvpmodel
    install -m 0440 ${WORKDIR}/gardena ${D}${sysconfdir}/sudoers.d/gardena
    install -m 0440 ${WORKDIR}/gardena-generic-resources ${D}${sysconfdir}/sudoers.d/gardena-generic-resources
    install -m 0440 ${WORKDIR}/advanced ${D}${sysconfdir}/sudoers.d/advanced
}

CONFFILES:${PN} += "${sysconfdir}/sudoers.d/gardena-nvpmodel"
CONFFILES:${PN} += "${sysconfdir}/sudoers.d/gardena"
CONFFILES:${PN} += "${sysconfdir}/sudoers.d/gardena-generic-resources"
CONFFILES:${PN} += "${sysconfdir}/sudoers.d/advanced"
