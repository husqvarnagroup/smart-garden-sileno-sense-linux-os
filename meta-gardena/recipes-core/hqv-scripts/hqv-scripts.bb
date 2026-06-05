DESCRIPTON = "Husqvarna utility scripts"

LICENSE = "CLOSED"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = " \
    file://install-isp-tuning.sh \
    file://install-imx675.sh \
    file://journaldump.sh \
    file://print-ubootenv.sh \
    file://reboot.sh \
    file://secure-system.sh \
    file://set-password.sh \
    file://set-ubootenv.sh \
    file://shutdown.sh \
    file://unsecure-system.sh \
    file://check-system-upgrade.sh \
"

S = "${WORKDIR}"

do_install() {
    install -d ${D}/hqv/scripts
    install -m 0755 ${WORKDIR}/reboot.sh ${D}/hqv/scripts/reboot.sh
    install -m 0755 ${WORKDIR}/secure-system.sh ${D}/hqv/scripts/secure-system.sh
    install -m 0755 ${WORKDIR}/set-password.sh ${D}/hqv/scripts/set-password.sh
    install -m 0755 ${WORKDIR}/set-ubootenv.sh ${D}/hqv/scripts/set-ubootenv.sh
    install -m 0755 ${WORKDIR}/shutdown.sh ${D}/hqv/scripts/shutdown.sh
    install -m 0755 ${WORKDIR}/unsecure-system.sh ${D}/hqv/scripts/unsecure-system.sh
    install -m 0755 ${WORKDIR}/install-isp-tuning.sh ${D}/hqv/scripts/install-isp-tuning.sh
    install -m 0755 ${WORKDIR}/install-imx675.sh ${D}/hqv/scripts/install-imx675.sh
    install -m 0755 ${WORKDIR}/print-ubootenv.sh ${D}/hqv/scripts/print-ubootenv.sh
    install -m 0755 ${WORKDIR}/check-system-upgrade.sh ${D}/hqv/scripts/check-system-upgrade.sh
    install -m 0755 ${WORKDIR}/journaldump.sh ${D}/hqv/scripts/journaldump.sh
}

FILES:${PN} += "/hqv/scripts/"
