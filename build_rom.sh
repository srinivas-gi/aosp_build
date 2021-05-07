#!/bin/bash

set -e
set -x

# sync rom
repo init --depth=1 -u git://github.com/LineageOS/android.git -b lineage-18.1
git clone https://github.com/Apon77Lab/android_.repo_local_manifests.git --depth 1 -b aex .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# setup build
git clone https://github.com/P-Salik/android_vendor_realme_RMX1941 vendor/realme/RMX1941
git clone https://github.com/P-Salik/android_device_realme_RMX1941 device/realme/RMX1941
cd external/selinux && wget https://raw.githubusercontent.com/SamarV-121/android_vendor_extra/lineage-18.1/patches/external/selinux/0001-Revert-libsepol-Make-an-unknown-permission-an-error-.patch && patch -p1 < *.patch && cd ../..

# build rom
source build/envsetup.sh
lunch lineage_RMX1941-user
export SKIP_ABI_CHECKS=true 
export SKIP_API_CHECKS=true 
mka api-stubs-docs
mka system-api-stubs-docs
mka test-api-stubs-docs
mka bacon -j8

# upload rom
up(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}

up out/target/productRMX1941/*.zip
