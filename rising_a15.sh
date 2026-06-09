#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/RisingOS-Revived/android -b qpr2 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Xtrakari/local_manifest_mh2lm.git .repo/local_manifests -b mh2lm-rising
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Build Sync
repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all) 
echo "============="
echo "Sync success"
echo "============="

# Export
export BUILD_USERNAME=Xtra 
export BUILD_HOSTNAME=crave
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
echo "======= Export Done ======"

# Delete Error Line
sed -i '/lirc_device/d' device/lineage/sepolicy/common/vendor/hal_ir_default.te
sed -i '/lirc_device/d' device/lineage/sepolicy/common/vendor/file_contexts
sed -i '/type lirc_device, dev_type;/d' device/lineage/sepolicy/common/vendor/device.te

# Set up build environment
source build/envsetup.sh
echo "============="

# Lunch 
riseup mh2lm userdebug

# Build 
rise b
