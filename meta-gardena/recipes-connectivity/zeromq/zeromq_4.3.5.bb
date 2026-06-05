DESCRIPTION = "ZeroMQ looks like an embeddable networking library but acts like a concurrency framework"
HOMEPAGE = "http://www.zeromq.org"
LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=9741c346eef56131163e13b9db1241b3"

PACKAGECONFIG ??= "libsodium"
PACKAGECONFIG[libsodium] = "-DWITH_LIBSODIUM=ON,-DWITH_LIBSODIUM=OFF, libsodium"

S = "${WORKDIR}/git"
SRC_URI = "gitsm://github.com/zeromq/libzmq;protocol=https;branch=master \
    file://0001-CMakeLists-txt-Avoid-host-specific-path-to-libsodium.patch \
    file://run-ptest \
"
SRCREV = "622fc6dde99ee172ebaa9c8628d85a7a1995a21d"

inherit cmake ptest pkgconfig

EXTRA_OECMAKE = "${@bb.utils.contains('PTEST_ENABLED', '1', '-DBUILD_TESTS=ON', '-DBUILD_TESTS=OFF', d)} \
                 -DCMAKE_SKIP_RPATH=ON \
"

do_install_ptest () {
    install -d ${D}${PTEST_PATH}/tests
    install -m 0755 ${B}/bin/test_* ${D}${PTEST_PATH}/tests
}

FILES:${PN}-doc += "${datadir}/zmq/*.txt"
