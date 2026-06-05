DESCRIPTION = "Search-Based Planning Library"
HOMEPAGE = "https://github.com/sbpl/sbpl"

LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://src/include/sbpl/config.h;endline=29;md5=90d91639efe091d80010b9e9c9fbcf71"

FILESEXTRAPATHS:prepend := "${THISDIR}/patches:"

SRC_URI += "git://github.com/sbpl/sbpl.git;branch=master;protocol=https; \
           file://0001-signed-char.patch \
           file://0002-version.patch \
           file://0003-max_allowed_memory.patch \
           "

SRCREV = "4d654845aa3b92aa1b4282a342e9011bac95aeb9"

S = "${WORKDIR}/git"

inherit cmake

EXTRA_OECMAKE += "  -DCMAKE_BUILD_TYPE=Release \
                    -DBUILD_SHARED_LIBS=ON \
                 "

do_install:append() {


}
