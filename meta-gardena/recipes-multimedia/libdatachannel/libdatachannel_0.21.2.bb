DESCRIPTION = "C/C++ WebRTC network library featuring Data Channels, Media Transport, and WebSockets"
HOMEPAGE = "https://github.com/paullouisageneau/libdatachannel"

LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=815ca599c9df247a0c7f619bab123dad"

SRC_URI = "gitsm://github.com/paullouisageneau/libdatachannel;protocol=https;branch=v0.21; \
		   "

SRCREV = "a0598f214b46217dd709f09522c601d5bc94b518"

S = "${WORKDIR}/git"

DEPENDS += "libnice"
DEPENDS += "openssl"

inherit cmake

EXTRA_OECMAKE += " -DNO_EXAMPLES=ON \
					-DNO_TESTS=ON \
					-DNO_WEBSOCKET=OFF \
					-DUSE_NICE=ON \
					-DCMAKE_BUILD_TYPE=Release \
                 "

do_install:append() {
}
