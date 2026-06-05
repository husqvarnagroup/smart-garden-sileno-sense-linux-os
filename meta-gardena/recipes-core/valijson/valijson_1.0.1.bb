DESCRIPTION = "Header-only C++ library for JSON Schema validation"
HOMEPAGE = "https://github.com/tristanpenman/valijson"

LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://LICENSE;md5=5c4583a434195e4f3b418e17c8ca2daf"

FILESEXTRAPATHS:prepend := "${THISDIR}/patches:"

SRC_URI = "git://github.com/tristanpenman/valijson.git;branch=master;protocol=https; \
           "

SRCREV = "f7399c1a244982632671906d17f3ea77f3ccfc67"

S = "${WORKDIR}/git"

inherit cmake

EXTRA_OECMAKE += "  -Dvalijson_BUILD_TESTS=OFF \
                    -Dvalijson_BUILD_EXAMPLES=OFF \
                 "

# valijson is a header only C++ library, so the main package will be empty.
RDEPENDS:${PN}-dev = ""

BBCLASSEXTEND = "native nativesdk"

do_install() {
    install -d ${D}${includedir}/compat
    install -d ${D}${includedir}/valijson
    install -d ${D}${includedir}/valijson/adapters
    install -d ${D}${includedir}/valijson/constraints
    install -d ${D}${includedir}/valijson/internal
    install -d ${D}${includedir}/valijson/utils

    install -m 0644 ${S}/include/compat/* ${D}${includedir}/compat
    install -D -m 0644 ${S}/include/valijson/*.hpp -t ${D}${includedir}/valijson
    install -D -m 0644 ${S}/include/valijson/adapters/*.hpp -t ${D}${includedir}/valijson/adapters
    install -D -m 0644 ${S}/include/valijson/constraints/*.hpp -t ${D}${includedir}/valijson/constraints
    install -D -m 0644 ${S}/include/valijson/internal/*.hpp -t ${D}${includedir}/valijson/internal
    install -D -m 0644 ${S}/include/valijson/utils/*.hpp -t ${D}${includedir}/valijson/utils
}
