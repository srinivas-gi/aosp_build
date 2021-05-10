#!/bin/bash

set -exv

# build rom
. build/envsetup.sh
lunch aosp_RMX1941-userdebug
export SKIP_API_CHECKS=true
export SKIP_ABI_CHECKS=true
cd /tmp/ci
export CCACHE_DIR=/tmp/ccache  ##use additional flags if you need(optional)
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1

ccache -M 30G
ccache -o compression=true
ccache -z
ccache -c

chmod -R 755 out/
mka bacon -j8
