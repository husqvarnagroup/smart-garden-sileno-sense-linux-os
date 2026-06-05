DESCRIPTION = "DBOW3 (Bag of Words)"
HOMEPAGE = "https://github.com/stella-cv/FBoW"

LICENSE = "CLOSED"

FILESEXTRAPATHS:prepend := "${THISDIR}/patches:"

SRC_URI += "git://github.com/stella-cv/FBoW.git;protocol=https;branch=master; \
            file://0001-no-highgui.patch \
           "

SRCREV = "c6e3c29e3332a0b0834021797e2aa4e8eb66a3c1"

S = "${WORKDIR}/git"

inherit cuda
DEPENDS += "opencv"

inherit cmake

EXTRA_OECMAKE += " -DBUILD_SHARED_LIBS=ON \
                   -DBUILD_UTILS=OFF \
                 "

do_install:append() {


}
