inherit image-gardena-top-layer

trim_rootfs() {
	rm -rf "${IMAGE_ROOTFS}/bin"
	rm -rf "${IMAGE_ROOTFS}/etc/*"
	rm -rf "${IMAGE_ROOTFS}/usr"
	rm -rf "${IMAGE_ROOTFS}/sbin"
	rm -rf "${IMAGE_ROOTFS}/lib"
	rm -rf "${IMAGE_ROOTFS}/var"
}

ROOTFS_POSTPROCESS_COMMAND:append = "trim_rootfs;"
