FILESEXTRAPATHS:prepend := "${THISDIR}/swupdate:"

SRC_URI += "file://01-target.conf"

do_install:append() {
    install -d ${D}/usr/lib/swupdate/conf.d
    install -m 0644 ${WORKDIR}/01-target.conf ${D}/usr/lib/swupdate/conf.d/01-target.conf
}

DEPENDS:append = " openssl"
