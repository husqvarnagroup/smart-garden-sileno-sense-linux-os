SUMMARY = "WiFi configuration"
DESCRIPTION = "Configuration and setup scripts for WiFi"
LICENSE = "CLOSED"

inherit systemd

SRC_URI = " \
    file://wpa_supplicant-wlan0.conf \
    file://wpa_supplicant@wlan0.service \
    file://wlan0.network \
    file://start-wifi.sh \
"

do_install() {
    # Install systemd service 
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/wpa_supplicant@wlan0.service ${D}${systemd_system_unitdir}/

    # Install wpa_supplicant configuration
    install -d ${D}${sysconfdir}/wpa_supplicant
    install -m 0644 ${WORKDIR}/wpa_supplicant-wlan0.conf ${D}${sysconfdir}/wpa_supplicant/

    # Install network configuration
    install -d ${D}${sysconfdir}/systemd/network
    install -m 0644 ${WORKDIR}/wlan0.network ${D}${sysconfdir}/systemd/network/

    # Install start script
    install -d ${D}/usr/bin
    install -m 0755 ${WORKDIR}/start-wifi.sh ${D}/usr/bin/
}

FILES:${PN} += " \
    ${systemd_system_unitdir}/wlan0-setup.service \
    ${sysconfdir}/wpa_supplicant/wpa_supplicant-wlan0.conf \
    ${sysconfdir}/systemd/network/wlan0.network \
"

SYSTEMD_SERVICE:${PN} = "wpa_supplicant@wlan0.service"
RDEPENDS:${PN} += "wpa-supplicant"
