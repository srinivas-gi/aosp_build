#!/bin/bash

set -exv

# build rom
. build/envsetup.sh
lunch aosp_RMX1941-userdebug
chmod -R 755 out/
mka bacon -j8
