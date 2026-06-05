inherit image-gardena

IMAGE_TEGRAFLASH_FS_TYPE = "tar"

EXTRA_USERS_PARAMS = ""

# Only installing to satisfy depencenies
IMAGE_INSTALL = " \
	kernel-image-image \
	u-boot-tegra-extlinux \
	sudo-toplayer \
	hqv-scripts \
"

PACKAGE_EXCLUDE:append = " \
	base-passwd \
	busybox-udhcpc \
	ldconfig \
	libattr1 \
	libcrypt2 \
	shadow \
	shadow-base \
	shadow-securetty \
	util-linux-sulogin \
	bash \
	zsh \
	run-postinsts \
	ncurses-terminfo-base \
"

create_whiteouts() {
	for file in ${WHITEOUT_FILES}; do
		dir=$(dirname "$file")

		if [ -e "${IMAGE_ROOTFS}${file}" ]; then
			rm -f "${IMAGE_ROOTFS}${file}"
		fi

		mkdir -p "${IMAGE_ROOTFS}${dir}"
		mknod "${IMAGE_ROOTFS}${file}" c 0 0
	done
}

ROOTFS_POSTPROCESS_COMMAND:append = "create_whiteouts;"
