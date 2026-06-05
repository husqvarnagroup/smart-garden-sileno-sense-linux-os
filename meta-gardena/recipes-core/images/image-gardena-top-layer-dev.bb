inherit image-gardena-top-layer

# Add extra packages for development
IMAGE_INSTALL += " \
	kernel-module-rtl8821cu \
	kernel-module-cfg80211 \
	linux-firmware-bcm43143 \
	wifi-configuration \
	wpa-supplicant \
"
