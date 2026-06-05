SUMMARY = "GARDENA OS"

LICENSE = "CLOSED"

inherit core-image

TOOLCHAIN_TARGET_TASK:append = " libstdc++-staticdev"
DEPENDS += "genimage-native u-boot-tools-native mtools-native dtc-native"

IMAGE_INSTALL = "packagegroup-core-boot ${CORE_IMAGE_EXTRA_INSTALL}"

IMAGE_LINGUAS = " en-us"
INCOMPATIBLE_LICENSE = "GPL-3.0* LGPL-3.0* AGPL-3.0*"
IMAGE_ROOTFS_SIZE ?= "8192"
IMAGE_ROOTFS_EXTRA_SPACE:append = "${@bb.utils.contains("DISTRO_FEATURES", "systemd", " + 4096", "" ,d)}"

RM_WORK_EXCLUDE:append = " image-gardena"

inherit extrausers
EXTRA_USERS_PARAMS = "\
    usermod -L root; \
    useradd gardena; \
    useradd advanced; \
	usermod -s /bin/zsh root; \
    usermod -s /bin/zsh gardena; \
    usermod -s /bin/zsh advanced; \
    usermod -a -G sudo gardena;\
    usermod -a -G video gardena;\
    usermod -a -G sudo advanced;\
    usermod -a -G video advanced;\
    "

GLIBC_GENERATE_LOCALES = "en_US.UTF-8"
IMAGE_TEGRAFLASH_FS_TYPE = "tar"

ROOTFS_POSTPROCESS_COMMAND += "create_mount_dirs;"

create_mount_dirs() {
    mkdir -p ${IMAGE_ROOTFS}/mnt/overlayfs
    mkdir -p ${IMAGE_ROOTFS}/mnt/lib-fs
    mkdir -p ${IMAGE_ROOTFS}/mnt/boot
}

IMAGE_INSTALL += " \
    aaplus \
    autostart-app \
    boost \
    busybox-udhcpc \
    cctz \
    chrony \
    chronyc \
    cryptsetup \
    cuda-cudart \
    cuda-nvrtc \
    cuda-nvrtc \
    cudnn \
    eeprom-expose \
    fmt \
    fuse \
    fuse-utils \
    gnutls \
    gptfdisk \
    gstreamer1.0-plugins-nvv4l2camerasrc \
    gstreamer1.0-plugins-nvvideo4linux2 \
    gstreamer1.0-plugins-tegra-binaryonly \
    hqv-scripts \
    imx675-config \
    iw \
    jsoncpp \
    kernel-module-imx675 \
    kernel-module-userspace-alert \
    l4t-usb-device-mode \
    ldd \
    libarchive \
    libidn \
    libstdc++ \
    libubootenv \
    libubootenv-bin \
    libunistring \
    libunwind \
    lsof \
    nettle \
    opencv \
    openssh \
    openssh-sftp-server \
    openssl \
    point-cloud-library \
    polkit \
    procps \
    protobuf \
    rtl8812au-mod \
    rtl8812bu-mod \
    shadow \
    squashfs-tools \
    strace \
    sudo \
    systemd \
    swupdate \
    tegra-libraries-core \
    tegra-libraries-cuda \
    tegra-nvpmodel \
    tegra-tools \
    tensorrt-core \
    tensorrt-plugins \
    tmux \
    tzdata \
    util-linux-lsblk \
    v4l-utils \
    zsh \
"
