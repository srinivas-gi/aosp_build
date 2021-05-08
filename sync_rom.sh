#!/bin/bash

set -exv

#sync rom
repo init --depth=1 -u https://github.com/CherishOS/android_manifest.git -b eleven
git clone https://github.com/P-Salik/local_manifest --depth=1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
