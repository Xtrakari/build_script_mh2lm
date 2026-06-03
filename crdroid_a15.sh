#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/crdroidandroid/android.git -b 15.0 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
# FIXME: Replace this URL/Branch with your actual mh2lm local manifest repository if different!
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

# Set up build environment
source build/envsetup.sh
echo "============="

# Lunch (Updated for LG G8X)
lunch lineage_mh2lm-ap4a-userdebug

# Build
mka bacon
