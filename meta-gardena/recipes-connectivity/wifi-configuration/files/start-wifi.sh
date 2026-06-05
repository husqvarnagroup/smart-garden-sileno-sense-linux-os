#! /bin/sh

if [ $# -lt 1 ]; then
    echo "Usage: $0 <wlan interface>" >&2
    exit 1
fi

IF="${1}"

/sbin/insmod /lib/modules/$(uname -r)/kernel/net/wireless/cfg80211.ko
/sbin/insmod /lib/modules/$(uname -r)/kernel/drivers/net/wireless/realtek/rtl8821cu/rtl8821cu.ko

/usr/sbin/wpa_supplicant -c/etc/wpa_supplicant/wpa_supplicant-"${IF}".conf -i"${IF}"
