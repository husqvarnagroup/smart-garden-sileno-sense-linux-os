DESCRIPTION = "A platform-independent promise library for C++, implementing asynchronous continuations."
HOMEPAGE = "https://github.com/grantila/q"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=e23fadd6ceef8c618fc1c65191d846fa"

FILESEXTRAPATHS:prepend := "${THISDIR}/patches:"

SRC_URI = "git://github.com/grantila/q.git;protocol=https;branch=master; \
           file://version-qa.patch \
           file://include.patch \
           "

SRCREV = "0117848bb3e6f0b130b546bc5851caf5f95f8b7e"

S = "${WORKDIR}/git"

inherit cmake

#TOOLCHAIN = "clang"
LIBCPLUSPLUS = ""
COMPILER_RT = ""
UNWINDLIB = ""
#LDFLAGS:append:toolchain-clang = " -fuse-ld=lld --gcc-toolchain=${STAGING_DIR_NATIVE}/usr/bin/aarch64-poky-linux -Wl,-L,${STAGING_DIR_TARGET}/lib -B${STAGING_DIR_TARGET}/usr/lib/aarch64-poky-linux/11.4.0 -Wl,-L,${STAGING_DIR_TARGET}/usr/lib/aarch64-poky-linux/11.4.0 -lpthread -ldl"
DEPENDS += "libgcc"

EXTRA_OECMAKE += "  -Dq_BUILD_TESTS=OFF \
                    -DBUILD_SHARED_LIBS=ON \
                    -DCMAKE_CXX_STANDARD=17 \
                 "

do_install:append() {


}

FILES:${PN}-dev += "/usr/share/q/cmake/*"
