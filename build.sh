#!/bin/sh
set -e

OUT_DIR="$(dirname $(readlink -f "$0"))/out"
IMG_DIR=build/tmp/deploy/images/gardena-jetson-nano
TEGRA_ARCHIVE=$IMG_DIR/image-gardena-top-layer-gardena-jetson-nano.tegraflash.tar.gz
ROOTFS_BOTTOM=$IMG_DIR/image-gardena-bottom-layer.squashfs

create_rootfs_imgs () {
    FAKEROOT_SCRIPT=fakeroot-script.sh
    echo "Generating fakeroot script: $FAKEROOT_SCRIPT"
    echo "# Automatically generated fakeroot script. Do not edit" > "$FAKEROOT_SCRIPT"
    echo "set -e" >> "$FAKEROOT_SCRIPT"

    echo "echo Creating top layer: image-gardena-top-layer.squashfs" >> "$FAKEROOT_SCRIPT"
    echo "mkdir rootfs" >> "$FAKEROOT_SCRIPT"
    echo "tar xf image-gardena-top-layer.tar -C rootfs" >> "$FAKEROOT_SCRIPT"
    echo "mksquashfs rootfs image-gardena-top-layer.squashfs -noappend -comp gzip" >> "$FAKEROOT_SCRIPT"

    echo "echo Creating ext4 overlay: overlay.ext4" >> "$FAKEROOT_SCRIPT"
    echo "mkdir rootfs-overlay" >> "$FAKEROOT_SCRIPT"

    # Add your files here

    # ext4 image size = 8G = 8589934592
    # Block size = 8589934592 / 1024 = 8388608
    # Make sure this value is synced with xml file: flash_l4t_t210_emmc_p3448.xml
    echo "mke2fs -t ext4 -b 1024 -d rootfs-overlay overlay.ext4 8388608" >> "$FAKEROOT_SCRIPT"

    chmod +x "$FAKEROOT_SCRIPT"

    echo "Running fakeroot script"
    rm -rf rootfs
    rm -rf rootfs-overlay
    fakeroot "$OUT_DIR/$FAKEROOT_SCRIPT"
}

create_uboot_img () {
    IMG="ubootenv.img"
    fallocate -l 1024k "${IMG}"
    mkfs.ext4 "${IMG}"

    tmp=$(mktemp)
    trap 'rm -f "${tmp}"' EXIT

    emit(){ printf '%s\n' "$*" >>"${tmp}"; }

    veritysetup format \
        --data-block-size="4096" \
        --hash-block-size="4096" \
        image-gardena-top-layer.squashfs \
        image-gardena-top-layer.squashfs.verity | grep "Root hash" | cut -f 2 > "image-gardena-top-layer.squashfs.hash"

    emit "write \"image-gardena-top-layer.squashfs.hash\" \"/rootfs-1.squashfs.hash\""
    emit "write \"image-gardena-top-layer.squashfs.hash\" \"/rootfs-2.squashfs.hash\""
    emit "write \"boot.scr\" \"/boot.scr\""

    if ! debugfs -w -f "${tmp}" "${IMG}"; then
        echo "debugfs batch failed" >&2
        exit 1
    fi
}

rm -rf $OUT_DIR
mkdir -p $OUT_DIR

./bbwrapper.sh image-gardena-bottom-layer
./bbwrapper.sh image-gardena-top-layer

if [ ! -f $TEGRA_ARCHIVE ]; then
    echo "Input archive not found: $IN_TARBALL"
    exit 1
fi

if [ ! -f $ROOTFS_BOTTOM ]; then
    echo "Input image not found: $ROOTFS_BOTTOM"
    exit 1
fi

tar -C $OUT_DIR -xf $TEGRA_ARCHIVE
cp $ROOTFS_BOTTOM $OUT_DIR

cd $OUT_DIR

sed -i "s/image-gardena-top-layer.tar/image-gardena-top-layer.squashfs image-gardena-bottom-layer.squashfs/" doflash.sh

create_rootfs_imgs
create_uboot_img

cd -
