FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI:append = " file://98-usb-gadget-tty.rules"

do_install:append() {
    install -m 0644 ${WORKDIR}/98-usb-gadget-tty.rules ${D}${sysconfdir}/udev/rules.d/

    install -d ${D}${systemd_system_unitdir}
    ln -sf /dev/null ${D}${systemd_system_unitdir}/serial-getty@ttyGS0.service
}

FILES:${PN} += "${systemd_system_unitdir}/serial-getty@ttyGS0.service"
