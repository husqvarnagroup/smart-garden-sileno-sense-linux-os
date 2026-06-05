FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
FILESEXTRAPATHS:prepend := "${THISDIR}/fragments:"
FILESEXTRAPATHS:prepend := "${THISDIR}/patches:"

SRC_URI += "file://custom.cfg \
            file://eeprom.cfg \
            file://0001-nvidia-Add-IMX675.patch \
            file://0002-dts-port-add-emc-dvfs-table-for-ramcode-1.patch \
            file://0003-Disable-Jetson-Nano-s-MCLK.patch \
            file://0004-Disable-DP-and-HDMI.patch \
            file://0005-tegra-camera-export-symbols-needed-by-imx675.patch \
            file://0006-imx675.c-add-customizable-exposure_factor.patch \
            file://0007-imx675.c-fix-some-issues-with-driver.patch \
            file://0008-add-imx675-dts-update-from-Thundersoft.patch \
            file://0009-tegra210-camera-sunny-imx675.dtsi-set-exposure_facto.patch \
            file://0010-nvidia-drivers-media-i2c-imx675.c-add-exposure_offse.patch \
            file://0011-arch-arm64-configs-tegra_defconfig-add-overlayfs-sup.patch \
            file://0012-nvidia-drivers-media-i2c-imx675.c-rename-to-num_line.patch \
            file://0013-nvidia-drivers-media-i2c-imx675.c-use-shutter-time-i.patch \
            "
