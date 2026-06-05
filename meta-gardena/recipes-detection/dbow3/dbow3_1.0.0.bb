DESCRIPTION = "DBOW3 (Bag of Words)"
HOMEPAGE = "https://github.com/rmsalinas/DBow3"

LICENSE = "dbow3"
NO_GENERIC_LICENSE[dbow3] = "LICENSE.txt"
LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=3c83b78b7d9f7d7447554be0333c5954"

FILESEXTRAPATHS:prepend := "${THISDIR}/patches:"

SRC_URI += "git://github.com/rmsalinas/DBow3.git;protocol=https;branch=master; \
            file://CMakeLists_txt.patch \
            file://config_cmake_in.patch \
            file://src_CMakeLists_txt.patch \
            file://bowvector.patch \
            file://0001-maxiterations.patch \
           "

SRCREV = "6d7196653767af4d58745ce4ca36d768d0da731a"

S = "${WORKDIR}/git"

inherit cuda
DEPENDS += "opencv"

inherit cmake

EXTRA_OECMAKE += " -DBUILD_SHARED_LIBS=ON \
                   -DBUILD_UTILS=OFF \
                 "

do_install:append() {


}
