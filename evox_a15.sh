#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/Evolution-X/manifest -b vic --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Xtrakari/local_manifest_mh2lm.git .repo/local_manifests -b main
echo "============================"
echo "Local manifest clone success"
echo "============================"

# CRITICAL FIX: Delete the old hardware/qcom directories BEFORE sync 
# This stops old, dead symlinks from breaking the build.
rm -rf hardware/qcom
rm -rf hardware/qcom_old

# Build Sync
/opt/crave/resync.sh 
echo "============="
echo "Sync success"
echo "============="

# Delete unnecessary folders
rm -rf device/linaro/hikey
rm -rf device/amlogic/yukawa

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
lunch lineage_mh2lm-bp1a-userdebug

# Build
m evolution
