#
# Copyright (C) 2013 Samsung Electronics Co., Ltd.
#              http://www.samsung.com/
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.
#
####################################

if [ -z $1 ]
then
    echo "usage: ./sd_fusing.sh <SD Reader's device file>"
    exit 0
fi

####################################
# fusing images

signed_bl1_position=1
bl2_position=31
uboot_position=63
tzsw_position=719
env_position=1231

#<BL1 fusing>
echo "BL1 fusing"
dd if=./bl1.bin.hardkernel of=$1 seek=$signed_bl1_position conv=sync

#<BL2 fusing>
echo "BL2 fusing"
dd if=./bl2.bin.hardkernel of=$1 seek=$bl2_position conv=sync

#<u-boot fusing>
echo "u-boot fusing"
dd if=./u-boot.bin.hardkernel of=$1 seek=$uboot_position conv=sync

#<TrustZone S/W fusing>
echo "TrustZone S/W fusing"
dd if=./tzsw.bin.hardkernel of=$1 seek=$tzsw_position conv=sync

#<u-boot env default>
echo "u-boot env erase"
dd if=/dev/zero of=$1 seek=$env_position count=32 bs=512 conv=sync

####################################
#<Message Display>
echo "U-boot image is fused successfully."
echo "Eject SD card and insert it again."
