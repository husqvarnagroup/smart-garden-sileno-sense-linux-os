SUMMARY = "Expose camera EEPROM content for user access"
DESCRIPTION = "Copies a sysfs EEPROM node to a user-readable file with proper permissions"
LICENSE = "CLOSED"

SRC_URI = "file://expose_eeprom.sh \
           file://expose-eeprom.service"

S = "${WORKDIR}"

inherit systemd
SYSTEMD_AUTO_ENABLE = "enable"

do_install() {
    install -d ${D}/usr/local/bin
    install -m 0755 ${WORKDIR}/expose_eeprom.sh ${D}/usr/local/bin/expose_eeprom.sh

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/expose-eeprom.service ${D}${systemd_system_unitdir}/expose-eeprom.service
}

SYSTEMD_SERVICE:${PN} = "expose-eeprom.service"
FILES:${PN} += "/usr/local/bin/expose_eeprom.sh"