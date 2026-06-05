SUMMARY = "RTL8812BU Kernel module for odroid USB WiFi dongle"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://LICENSE;md5=b234ee4d69f5fce4486a80fdaf4a4263"

FILESEXTRAPATHS:prepend := "${THISDIR}/patches:"

inherit module
SRC_URI = "git://github.com/fastoe/RTL8812BU.git;protocol=https;branch=v5.6.1 \
            file://yocto-style-compile.patch \
"
SRCREV = "6e492d34870497b9530bb728b401a5241d29f6e2"

S = "${WORKDIR}/git"

# The inherit of module.bbclass will automatically name module packages with
# "kernel-module-" prefix as required by the oe-core build environment.

RPROVIDES:${PN} += "kernel-module-rtl8812bu"

