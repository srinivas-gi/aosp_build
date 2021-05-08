#!/bin/bash

set -exv

#sync rom

repo init --depth=1 -u https://github.com/CherishOS/android_manifest.git -b eleven

git clone https://github.com/P-Salik/local_manifest --depth=1 -b main .repo/local_manifests

repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)

# patches
sudo apt install wget -y

cd external/selinux
wget https://github.com/PixelExperience/external_selinux/commit/9d6ebe89430ffe0aeeb156f572b2a810f9dc98cc.patch
patch -p1 < *.patch
cd ../..

cd frameworks/base
wget https://github.com/PixelExperience/frameworks_base/commit/37f5a323245b0fd6269752742a2eb7aa3cae24a7.patch
patch -p1 < *.patch
cd ../..

cd frameworks/opt/net/wifi
wget https://github.com/PixelExperience/frameworks_opt_net_wifi/commit/3bd2c14fbda9c079a4dc39ff4601ba54da589609.patch
patch -p1 < *.patch
cd ../../../..

cd frameworks/opt/net/ims
wget https://github.com/PixelExperience/frameworks_opt_net_ims/commit/661ae9749b5ea7959aa913f2264dc5e170c63a0a.patch
patch -p1 < *.patch
cd ../../../../

chmod -R 755 frameworks/
