
FILESEXTRAPATHS:prepend := "${THISDIR}/patches:${THISDIR}/files:"

DEPENDS:append = " genimage-native u-boot-tools-native mtools-native "

SRC_URI += "file://0001-configs-p3450-0002_defconfig-add-squashfs-support.patch \
	file://0002-configs-p3450-0002_defconfig-move-env-to-FAT.patch \
	file://0003-configs-p3450-0002_defconfig-set-correct-env-partiti.patch \
	file://0004-configs-p3450-0002_defconfig-add-support-for-FIT-ima.patch \
	file://0005-configs-p3450-0002_defconfig-add-bootcounter.patch \
	file://0006-configs-p3450-0002_defconfig-add-bootcount-command.patch \
	file://0007-configs-p3450-0002_defconfig-add-redundant-environme.patch \
	file://0008-configs-p3450-0002_defconfig-update-default-bootcmd.patch \
	file://0009-Revert-configs-p3450-0002_defconfig-add-support-for-.patch \
	file://0010-configs-p3450-0002_defconfig-move-env-to-mmc.patch \
"

UBOOT_EXTLINUX_KERNEL_IMAGE = "/boot/Image"

UBOOT_EXTLINUX_INITRD = "/boot/initrd"

do_compile[depends] += "linux-tegra:do_populate_sysroot tegra-minimal-initramfs:do_install"

do_install:append() {
    rm -f ${D}/etc/fw_env.config
}

