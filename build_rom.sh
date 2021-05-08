#!/bin/bash

set -exv

# building rom
. build/envsetup.sh
lunch arrow_RMX1941-userdebug
m bacon
