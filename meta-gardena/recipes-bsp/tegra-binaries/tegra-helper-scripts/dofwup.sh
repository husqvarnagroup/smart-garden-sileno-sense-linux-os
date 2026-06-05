#!/bin/sh

set -e

here=$(readlink -f $(dirname "$0"))
signed_output=.

rm -rf $here/signed

echo "BOARDID=3448" > $here/flashvars
echo "FAB=300" >> $here/flashvars
echo "BOARDSKU=0002" >> $here/flashvars
echo "BOARDREV=b00" >> $here/flashvars

MACHINE=eeve-jetson-nano ./tegra210-flash-helper.sh -B 1048576 --sign -b image-eeve flash.xml.in tegra210-p3448-0002-p3449-0000-b00.dtb eeve-jetson-nano.cfg 0x94000 "" u-boot-eeve-jetson-nano.bin "image-eeve.ext4" -b image-eeve

