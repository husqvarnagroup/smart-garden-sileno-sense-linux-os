inherit image-gardena-top-layer

RM_WORK_EXCLUDE:append = " image-gardena-top-layer-dev"

EXTRA_USERS_PARAMS = "\
    usermod -p '' root; \
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

# Add extra packages for development
IMAGE_INSTALL += " \
	kernel-module-rtl8821cu \
	kernel-module-cfg80211 \
	linux-firmware-bcm43143 \
	wifi-configuration \
	wpa-supplicant \
"

PACKAGE_EXCLUDE:remove = " \
    base-passwd \
    libattr1 \
    libcrypt2 \
    shadow \
    shadow-base \
    shadow-securetty \
    util-linux-sulogin \
"
