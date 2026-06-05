DESCRIPTION = "C++ Requests: Curl for People, a spiritual port of Python Requests"
HOMEPAGE = "https://github.com/libcpr/cpr"

LICENSE = "CLOSED"

SRC_URI += "git://github.com/libcpr/cpr.git;protocol=https;branch=master \
           "

SRCREV = "beb9e98806bb84bcc130a2cebfbcbbc6ce62b335"

S = "${WORKDIR}/git"

DEPENDS += "curl"

inherit cmake

EXTRA_OECMAKE += " -DCPR_BUILD_TESTS=OFF \
					-DBUILD_SHARED_LIBS=ON \
                    -DCPR_FORCE_USE_SYSTEM_CURL=ON \
                 "

do_install:append() {

}
