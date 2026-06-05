#!/bin/sh

LOCAL_KO=/home/gardena/54.3_Vision-App/_FSMower/data/imx675.ko
INSTALLED_KO=/lib/modules/$(uname -r)/kernel/drivers/media/i2c/imx675.ko

if [ ! -s "${LOCAL_KO}" ]; then
    echo "${LOCAL_KO} does not exist or is zero bytes! Aborting..."
	exit 1
fi

if ! cmp -s "${LOCAL_KO}" "${INSTALLED_KO}"; then
    sudo mv "${LOCAL_KO}" "${INSTALLED_KO}"
    sudo chown root:root "${INSTALLED_KO}"
    sudo chmod 644 "${INSTALLED_KO}"
    echo "Installed ${LOCAL_KO} to ${INSTALLED_KO}"
else
    echo "${INSTALLED_KO} is already up-to-date"
fi

sudo sync
