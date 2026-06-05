inherit deploy

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI:append = "\
    file://init-boot-hqv.sh \
"

do_install[depends] += "u-boot-env-generator:do_deploy"

do_install:append() {
    install -m 0755 ${WORKDIR}/init-boot-hqv.sh ${D}/init
    install -m 0644 ${DEPLOY_DIR_IMAGE}/uboot-env-${MACHINE}.bin ${D}/uboot-env.bin
    install -m 0644 ${DEPLOY_DIR_IMAGE}/boot-${MACHINE}.scr ${D}/boot.scr
}
