FILESEXTRAPATHS:prepend := "${THISDIR}/tegra-libraries-camera:"

# Add the camera_overrides.isp file to the source
SRC_URI += "file://camera_overrides.isp"

# Install the file to the correct target path
do_install:append() {
    install -m 0664 ${WORKDIR}/camera_overrides.isp ${D}/var/nvidia/nvcam/settings/
}
