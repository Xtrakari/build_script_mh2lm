#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/LineageOS/android.git -b lineage-22.2 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Xtrakari/local_manifest_mh2lm.git .repo/local_manifests -b main
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Build Sync
/opt/crave/resync.sh 
echo "============="
echo "Sync success"
echo "============="

# Export
export BUILD_USERNAME=Xtra
export BUILD_HOSTNAME=crave
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
echo "======= Export Done ======"

# Delete Error Line
sed -i '/type lirc_device, dev_type;/d' device/lineage/sepolicy/common/vendor/device.te

# Set up build environment
source build/envsetup.sh
echo "============="

# Lunch
lunch lineage_mh2lm-bp1a-userdebug

# Build
mka bacon
