FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://50-reboot.rules"

do_install:append() {
    install -d ${D}${sysconfdir}/polkit-1/rules.d
    install -m 0644 ${WORKDIR}/50-reboot.rules ${D}${sysconfdir}/polkit-1/rules.d/50-reboot.rules
}

CONFFILES:${PN} += "${sysconfdir}/polkit-1/rules.d/50-reboot.rules"
