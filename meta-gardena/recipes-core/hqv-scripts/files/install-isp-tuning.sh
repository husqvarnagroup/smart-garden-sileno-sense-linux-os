#!/bin/sh

TUNING_ISP=/home/gardena/54.3_Vision-App/_FSMower/data/camera_overrides.isp
CAMERA_OVERRIDES_ISP=/var/nvidia/nvcam/settings/camera_overrides.isp

if ! cmp -s $TUNING_ISP $CAMERA_OVERRIDES_ISP; then
    sudo mv $TUNING_ISP $CAMERA_OVERRIDES_ISP
    sudo chown root:root $CAMERA_OVERRIDES_ISP
    sudo chmod 644 $CAMERA_OVERRIDES_ISP
    echo "Installed $TUNING_ISP to $CAMERA_OVERRIDES_ISP"
else
    echo "$CAMERA_OVERRIDES_ISP is already up-to-date"
fi

sync
