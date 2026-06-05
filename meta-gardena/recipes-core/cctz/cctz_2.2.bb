DESCRIPTION = "CCTZ is a C++ library for translating between absolute and civil times using the rules of a time zone."
HOMEPAGE = "https://github.com/google/cctz"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57"

FILESEXTRAPATHS:prepend := "${THISDIR}/patches:"

SRC_URI = "https://github.com/google/cctz/archive/v${PV}.tar.gz \
           file://CMakeLists_txt.patch \
           "

SRC_URI[md5sum] = "5905460b08f08a60dbbed27bf98bfe84"
SRC_URI[sha256sum] = "ab315d5beb18a65ace57f6ea91f9ea298ec163fee89f84a44e81732af4d07348"

S = "${WORKDIR}/cctz-${PV}"

#DEPENDS += "libeigen"

inherit cmake

EXTRA_OECMAKE += "  -DBUILD_TOOLS=OFF \
                    -DBUILD_EXAMPLES=OFF \
                    -DBUILD_SHARED_LIBS=ON \
                    -DBUILD_TESTING=OFF \
                 "

do_install:append() {


}
