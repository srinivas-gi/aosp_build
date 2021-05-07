#!/bin/bash

set -e
set -x

# sync rom
repo init --depth=1 -u git://github.com/AospExtended/manifest.git -b 11.x
git clone https://github.com/Apon77Lab/android_.repo_local_manifests.git --depth 1 -b aex .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# trees
git clone https://github.com/P-Salik/android_device_realme_RMX1941 device/realme/RMX1941
git clone https://github.com/P-Salik/android_vendor_realme_RMX1941 vendor/realme/RMX1941
cd /external/selinux git fetch https://github.com/PixelExperience/external_selinux && git cherry-pick 9d6ebe89430ffe0aeeb156f572b2a810f9dc98cc
cd ../..
cd /frameworks/base git fetch https://github.com/PixelExperience/frameworks_base && git cherry-pick 37f5a323245b0fd6269752742a2eb7aa3cae24a7
cd ../..
cd /frameworks/opt/net/wifi git fetch https://github.com/PixelExperience/frameworks_opt_net_wifi && git cherry-pick 3bd2c14fbda9c079a4dc39ff4601ba54da589609
cd ../../../..
cd /frameworks/opt/net/ims git fetch https://github.com/PixelExperience/frameworks_opt_net && git cherry-pick 661ae9749b5ea7959aa913f2264dc5e170c63a0a
cd ../../../..
# build rom

source build/envsetup.sh
lunch aosp_RMX1941-user
m aex -j$(nproc --all)

# upload rom
up(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}

up out/target/product/RMX1941/*.zip
