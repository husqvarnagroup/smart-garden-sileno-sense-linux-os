inherit image-gardena

IMAGE_TEGRAFLASH_FS_TYPE = "squashfs"

remove_boot_dir() {
	rm -rf "${IMAGE_ROOTFS}/boot/"
}

ROOTFS_POSTPROCESS_COMMAND:append = "remove_boot_dir;"
