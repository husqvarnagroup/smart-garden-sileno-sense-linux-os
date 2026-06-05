inherit deploy

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI:append = "\
    file://uboot.env \
    file://boot.script \
"
LICENSE = "CLOSED"

do_compile:append() {
    mkenvimage -r -s 0x8000 -o ${B}/uboot-env.bin ${WORKDIR}/uboot.env

    mkimage -A arm \
        -T script \
        -C none \
        -d ${WORKDIR}/boot.script ${B}/boot.scr
}

do_deploy() {
    install -m 0644 ${B}/uboot-env.bin ${DEPLOYDIR}/uboot-env-${MACHINE}.bin
    install -m 0644 ${B}/boot.scr ${DEPLOYDIR}/boot-${MACHINE}.scr
}

DEPENDS += "u-boot-tools-native"

addtask deploy after do_compile
