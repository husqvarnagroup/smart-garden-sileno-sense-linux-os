FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

hostname:pn-base-files = "sileno"

SRC_URI += "file://zprofile"
SRC_URI += "file://zshrc"
SRC_URI += "file://99-gardena.rules"
SRC_URI += "file://camera-settings/front_cameracalibration_intrinics.xml" 
SRC_URI += "file://fw_env.config"

do_install:append () {
    
    install -d ${D}${sysconfdir}/udev/rules.d
    install -m 0777 -d ${D}/home/gardena
    install -m 0777 -d ${D}/home/gardena/data
    install -m 0777 ${WORKDIR}/zshrc ${D}/home/gardena/.zshrc
    install -m 0777 ${WORKDIR}/camera-settings/front_cameracalibration_intrinics.xml ${D}/home/gardena/data/front_cameracalibration_intrinics.xml

    install -m 0644 ${WORKDIR}/zprofile ${D}${sysconfdir}/zprofile
    install -m 0644 ${WORKDIR}/99-gardena.rules ${D}${sysconfdir}/udev/rules.d/99-gardena.rules
    install -m 0644 ${WORKDIR}/fw_env.config ${D}${sysconfdir}/fw_env.config
    echo "Welcome to Gardena OS ${DISTRO_VERSION}" > ${D}${sysconfdir}/motd
    echo "----------------------------" >> ${D}${sysconfdir}/motd
}

