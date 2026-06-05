#!/bin/sh
PATH=/sbin:/bin:/usr/sbin:/usr/bin

mkdir -p /proc /sys /dev

mount -t proc proc /proc
mount -t devtmpfs none /dev
mount -t sysfs sysfs /sys

DEBUG_DEV=/dev/ttyS0

missing_cmdline_options=0

root_part=$(sed 's/ /\n/g' < /proc/cmdline | grep -i root_part_num=)
root_part=${root_part##*root_part_num=}
if [ -n "$root_part" ]; then
	root_part=$(printf "%d" "$root_part")
else
	root_part=1
	missing_cmdline_options=1
fi

user_data_part=$(sed 's/ /\n/g' < /proc/cmdline | grep -i uda_part_num=)
user_data_part=${user_data_part##*uda_part_num=}
if [ -n "$user_data_part" ]; then
	user_data_part=$(printf "%d" "$user_data_part")
else
	user_data_part=22
fi

boot_part=$(sed 's/ /\n/g' < /proc/cmdline | grep -i boot_part_number=)
boot_part=${boot_part##*boot_part_number=}
if [ -n "$boot_part" ]; then
	boot_part=$(printf "%d" "$boot_part")
else
	boot_part=3
fi

verity_part=$(sed 's/ /\n/g' < /proc/cmdline | grep -i verity_part_number=)
verity_part=${verity_part##*verity_part_number=}
if [ -n "$verity_part" ]; then
	verity_part=$(printf "%d" "$verity_part")
else
	verity_part=4
fi

libfs_part=21

rootdev="/dev/mmcblk0p${root_part}"
libfsdev="/dev/mmcblk0p${libfs_part}"
userdev="/dev/mmcblk0p${user_data_part}"
bootdev="/dev/mmcblk0p${boot_part}"
veritydev="/dev/mmcblk0p${verity_part}"

mkdir -p /mnt/new_root
mkdir -p /mnt/boot
mkdir -p /mnt/overlay
VERITY_HASH=/mnt/boot/rootfs-${root_part}.squashfs.hash

wait_for_device() {
	dev="$1"
	timeout=0

	echo "Waiting for ${dev} to become ready" > ${DEBUG_DEV}
	while [ ! -b "${dev}" ];do
		usleep 100
		timeout=$((timeout + 1))
		if [ $timeout -gt 1000000 ];then
			echo "Wait ${dev} Creation timeout!" > ${DEBUG_DEV}
			return 1
		fi
	done

    return 0
}

check_ext4_fs() {
	dev="$1"

	fsck.ext4 -y "$dev"
	RET="$?"

	case "${RET}" in
		0|1|2)
			return 0
			;;
		*)
			return "${RET}"
			;;
	esac
}

recreate_boot_fs() {
	echo "Recreating ${bootdev} since it is deemed corrupt!" > ${DEBUG_DEV}
	/sbin/mke2fs -FF -t ext4 "${bootdev}" > ${DEBUG_DEV}
	mount -t ext4 "${bootdev}" /mnt/boot

	echo "Copying boot script to ${bootdev}" > ${DEBUG_DEV}
	cp /boot.scr /mnt/boot/boot.scr

	echo "Creating verity hash for ${rootdev}" > ${DEBUG_DEV}
	veritysetup format \
		--data-block-size="4096" \
		--hash-block-size="4096" \
		"${rootdev}" \
		"${veritydev}" | grep "Root hash" | cut -f 2 > "/mnt/boot/rootfs-1.squashfs.hash"

	umount /mnt/boot
}

recreate_overlay_fs() {
	echo "Recreating ${userdev}" > ${DEBUG_DEV}
	/sbin/mke2fs -FF -t ext4 "${userdev}" > ${DEBUG_DEV}
	mount -t ext4 "${userdev}" /mnt/overlay > ${DEBUG_DEV}
	mkdir -p /mnt/overlay/overlay
	umount /mnt/overlay
}

if [ "${missing_cmdline_options}" = 0 ]; then
	if ! wait_for_device "${bootdev}"; then
		echo "Unable to wait for ${bootdev}. rebooting"> ${DEBUG_DEV}
		echo b > /proc/sysrq-trigger
    fi

	sleep 0.1

	if ! check_ext4_fs "${bootdev}"; then
		recreate_boot_fs
	fi

	mount "${bootdev}" /mnt/boot

	if ! veritysetup verify "${rootdev}" "${veritydev}" --root-hash-file="${VERITY_HASH}"; then
		echo Filesystem corruption detected, rebooting > ${DEBUG_DEV}
		umount /mnt/boot
		echo b > /proc/sysrq-trigger
	fi
	umount /mnt/boot
else
	# Missing cmdline means corrupt boot script. We must try to recreate the boot partition.
	# We also recreate the overlay since we will go back to the A partition in the next boot.
	# This is the safest thing do in case the application in the overlay does not work with the image
	echo "Missing command line options. Reformatting boot partition and overlay!" > ${DEBUG_DEV}
	recreate_boot_fs
	recreate_overlay_fs
fi

if ! wait_for_device "${rootdev}"; then
	echo "Unable to wait for ${rootdev}. rebooting"> ${DEBUG_DEV}
	echo b > /proc/sysrq-trigger
fi

sleep 0.1

# Mount squashfs. We will only get here if the hash is correct.
echo "Mounting ${rootdev} in /mnt/new_root" > ${DEBUG_DEV}
mount -t squashfs "${rootdev}" /mnt/new_root > ${DEBUG_DEV}

if ! check_ext4_fs "${userdev}"; then
	recreate_overlay_fs
fi

if ! wait_for_device "${libfsdev}"; then
	echo "Unable to wait for ${libfsdev}. rebooting"> ${DEBUG_DEV}
	echo b > /proc/sysrq-trigger
fi

sleep 0.1

# Mount squashfs for libfsdev. If mounting this device fails there is nothing we can do
# but continuing on.
echo Mounting ${libfsdev} > ${DEBUG_DEV}
mount -t squashfs "${libfsdev}" /mnt/new_root/mnt/lib-fs > ${DEBUG_DEV}

# Mount overlay. We will only get here if fsck has succeeded or the partition
# has been recreated.
echo "Mounting ${userdev} in /mnt/new_root/mnt/overlayfs" > ${DEBUG_DEV}
mount -t ext4 "${userdev}" /mnt/new_root/mnt/overlayfs

mkdir -p /mnt/new_root/mnt/overlayfs/overlay
mkdir -p /mnt/new_root/mnt/overlayfs/overlay-workdir
echo Mounting overlay fs > ${DEBUG_DEV}
mount -n -t overlay overlay -o \
	lowerdir=/mnt/new_root:/mnt/new_root/mnt/lib-fs,upperdir=/mnt/new_root/mnt/overlayfs/overlay,workdir=/mnt/new_root/mnt/overlayfs/overlay-workdir \
	/mnt/new_root > ${DEBUG_DEV}

echo Remounting /sys /proc /dev in new rootfs > ${DEBUG_DEV}
mount -n --move /sys /mnt/new_root/sys
mount -n --move /proc /mnt/new_root/proc
mount -n --move /dev /mnt/new_root/dev
cd /mnt/new_root || true

echo "Switching root" > ${DEBUG_DEV}
exec switch_root . /sbin/init
