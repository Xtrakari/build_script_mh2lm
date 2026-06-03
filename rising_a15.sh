#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/RisingOS-Revived/android.git -b fifteen --git-lfs
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

# Export Env Vars
export BUILD_USERNAME=Xtra
export BUILD_HOSTNAME=crave
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true

# --- GMS Flags (Perfectly fine for mh2lm) ---
export WITH_GMS=true
export TARGET_CORE_GMS=true
export TARGET_CORE_GMS_EXTRAS=true
export TARGET_DEFAULT_PIXEL_LAUNCHER=true
export TARGET_INCLUDE_GOOGLE_DIALER=true
# --------------------------------------------

echo "======= Export Done ======"

# Delete Error Line (Note: Only keep this if rising's sepolicy triggers this exact error on sm8150)
sed -i '/type lirc_device, dev_type;/d' device/lineage/sepolicy/common/vendor/device.te

# Set up build environment
source build/envsetup.sh
echo "============="

# Lunch - Changed export mh2lm
riseup mh2lm userdebug

# Build 
rise b
