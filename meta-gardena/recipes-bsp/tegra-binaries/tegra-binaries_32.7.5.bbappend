
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://overlay_32.7.5_PCN211181.tbz2"

do_install:append() {
    tar xvf ${WORKDIR}/overlay_32.7.5_PCN211181.tbz2 -C ${S}
}
