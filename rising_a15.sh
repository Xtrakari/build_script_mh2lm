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

# 1. FIXED: Added '-m rising.xml' so repo knows where the core manifest is
repo init -u https://github.com/Xtrakari/android.git -b fix --depth=1 --git-lfs -m rising.xml

# Clone local_manifests repository (Now has your updated XML!)
git clone https://github.com/Xtrakari/local_manifest_mh2lm.git --depth 1 -b mh2lm-rising .repo/local_manifests

# repo sync
/opt/crave/resync.sh

# Initialize the build environment variables
source build/envsetup.sh

# 2. FIXED: Changed 'userdebug' to match standard riseup format
riseup mh2lm

gk -s

# Standard compile command
rise b
