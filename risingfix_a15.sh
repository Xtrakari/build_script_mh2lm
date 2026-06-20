rm -rf .repo/local_manifests/
rm -rf device/lge
rm -rf kernel/lge
rm -rf vendor/lge
rm -rf hardware/lge
rm -rf build/soong
rm -rf out/target/product/mh2lm
# Cleanup previous changelog to make it always fresh
rm -rf out/target/product/*/system/etc/Changelog.txt \
       out/target/product/*/obj/ETC/Changelog.txt_intermediates \
       out/target/product/*/gen/ETC/Changelog.txt_intermediates

# 1. FIXED: Removed -m rising.xml so it initializes cleanly
repo init -u https://github.com/Xtrakari/android.git -b fix --depth=1 --git-lfs

# 2. FIXED: Added the force symlink so repo uses the correct RisingOS layout
ln -sf snippets/rising.xml .repo/manifests/default.xml

# Clone local_manifests repository
git clone https://github.com/Xtrakari/local_manifest_mh2lm.git --depth 1 -b mh2lm-rising .repo/local_manifests

# repo sync
repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all) 

# Initialize the build environment variables
source build/envsetup.sh

# Set standard riseup format
riseup mh2lm userdebug

# Standard compile command
rise b
