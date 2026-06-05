DESCRIPTION = "FLANN is a library for performing fast approximate nearest neighbor searches in high dimensional spaces."
HOMEPAGE = "http://www.cs.ubc.ca/research/flann"

LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://COPYING;md5=040a44ba915aa6b3b099ea189c7b7e20"

FILESEXTRAPATHS:prepend := "${THISDIR}/patches:${THISDIR}/src:"

SRC_URI = "git://github.com/kjinxin/${BPN}-${PV}-src.git;protocol=https;branch=master; \
           file://CMakeLists_txt.patch \
           file://src_cpp_CMakeLists_txt.patch \
           file://empty.c \
           file://empty.cpp \
          "

SRCREV = "ba1a0ac17bfb2554c2c51590937eb5b64539753a"

S = "${WORKDIR}/git"

#DEPENDS += "libeigen"

inherit cmake

EXTRA_OECMAKE += "  -DBUILD_PYTHON_BINDINGS=Off \
                    -DBUILD_MATLAB_BINDINGS=Off \
                 "

do_configure:prepend() {
    cp ${WORKDIR}/empty.c ${S}/src/cpp
    cp ${WORKDIR}/empty.cpp ${S}/src/cpp

}

