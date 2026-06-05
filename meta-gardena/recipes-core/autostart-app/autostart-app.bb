DESCRIPTON = "Autostart 54.3_Vision-App using systemd"

LICENSE = "CLOSED"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = " \
    file://54.3_Vision-App.service \
    file://54.103_Vision-Boot.service \
    file://os-upgrade-check.service \
"

SYSTEMD_SERVICE:${PN} = "54.3_Vision-App.service 54.103_Vision-Boot.service os-upgrade-check.service"
SYSTEMD_AUTO_ENABLE = "enable"

inherit systemd

S = "${WORKDIR}"

do_install() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/54.3_Vision-App.service ${D}${systemd_system_unitdir}/54.3_Vision-App.service
    install -m 0644 ${WORKDIR}/54.103_Vision-Boot.service ${D}${systemd_system_unitdir}/54.103_Vision-Boot.service
    install -m 0644 ${WORKDIR}/os-upgrade-check.service ${D}${systemd_system_unitdir}/os-upgrade-check.service
}

FILES:${PN} += " \
    ${systemd_system_unitdir}/54.3_Vision-App.service \
    ${systemd_system_unitdir}/54.103_Vision-Boot.service \
    ${systemd_system_unitdir}/os-upgrade-check.service \
"
