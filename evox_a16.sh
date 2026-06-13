#!/bin/bash

# 1. Clean up old directories to ensure a fresh state
rm -rf .repo/local_manifests/
rm -rf device/lge
rm -rf kernel/lge
rm -rf vendor/lge
rm -rf hardware/lge
rm -rf build/soong
rm -rf out/target/product/mh2lm
rm -rf fuck-bpf  # Clear old patch utility folder if it exists

# Cleanup previous changelog to make it always fresh
rm -rf out/target/product/*/system/etc/Changelog.txt \
       out/target/product/*/obj/ETC/Changelog.txt_intermediates \
       out/target/product/*/gen/ETC/Changelog.txt_intermediates

# 2. Initialize Evolution X source tree (Android 15 Base)
repo init -u https://github.com/Evolution-X/manifest -b bq2 --depth=1 --git-lfs

# Clone local_manifests repository specifically for your mh2lm setup
git clone https://github.com/Xtrakari/local_manifest_mh2lm.git --depth 1 -b mh2lm-evox16 .repo/local_manifests
if [ ! $? -eq 0 ]; then   
    curl -o .repo/local_manifests https://github.com/Xtrakari/local_manifest_mh2lm.git
fi

# 3. Synchronize the repositories via Crave's infrastructure
/opt/crave/resync.sh

# 4. Apply your custom PixelPropsUtils spoofing tweaks (Lazada & Shopee)
grep -q '"com.lazada.android"' frameworks/base/core/java/com/android/internal/util/evolution/PixelPropsUtils.java || \
sed -i '/"com.android.chrome",/a\        "com.lazada.android",\n        "com.shopee.my",' frameworks/base/core/java/com/android/internal/util/evolution/PixelPropsUtils.java
cat frameworks/base/core/java/com/android/internal/util/evolution/PixelPropsUtils.java

# ==========================================
# EXTRA CRITICAL STEP: INTEGRATE FUCK-BPF
# ==========================================
echo "=== Cloning and applying fuck-bpf utility ==="
git clone https://github.com/techyminati/fuck-bpf.git -b lineage-23.2 --depth 1
chmod +x fuck-bpf/apply.sh
./fuck-bpf/apply.sh --mb
# ==========================================

# 5. Set up the build environment
source build/envsetup.sh

# Target configuration choice for mh2lm
lunch lineage_mh2lm-bp4a-userdebug

# Wipe previous output files safely
make installclean

# 6. Execute the build process
m evolution
