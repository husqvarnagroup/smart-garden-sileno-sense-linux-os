DESCRIPTION = "C++ Requests: Curl for People, a spiritual port of Python Requests"
HOMEPAGE = "https://github.com/libcpr/cpr"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=08beaae5deae1c43c065592da8f38095"

SRC_URI += "git://github.com/libcpr/cpr.git;protocol=https;branch=1.9.x \
           "

SRCREV = "7a02d679308a19220e3b75616c18ff9e8deb5f9a"

S = "${WORKDIR}/git"

DEPENDS += "curl"

inherit cmake

EXTRA_OECMAKE += " -DCPR_BUILD_TESTS=OFF \
					-DBUILD_SHARED_LIBS=ON \
                    -DCPR_FORCE_USE_SYSTEM_CURL=ON \
                 "

do_install:append() {

}
