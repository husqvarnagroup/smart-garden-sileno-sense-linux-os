SUMMARY = "RTL8812AU Kernel module for odroid USB WiFi dongle"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://LICENSE;md5=b234ee4d69f5fce4486a80fdaf4a4263"

FILESEXTRAPATHS:prepend := "${THISDIR}/patches:"

inherit module
SRC_URI = "git://github.com/aircrack-ng/rtl8812au.git;protocol=https;branch=v5.6.4.2 \
            file://yocto-style-compile.patch \
"
SRCREV = "548497065967aec00dd7b804678222bd29d658b6"

S = "${WORKDIR}/git"

# The inherit of module.bbclass will automatically name module packages with
# "kernel-module-" prefix as required by the oe-core build environment.

RPROVIDES:${PN} += "kernel-module-rtl8812au"

