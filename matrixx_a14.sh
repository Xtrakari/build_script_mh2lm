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

# Clone axion
repo init -u https://github.com/ProjectMatrixx/android.git -b 14.0 --depth=1 --git-lfs

# Clone local_manifests repository
git clone https://github.com/Xtrakari/local_manifest_mh2lm.git --depth 1 -b mh2lm-matrixx .repo/local_manifests

# repo sync
repo sync -c --force-sync --no-tags --no-clone-bundle -j$(nproc --all) 

# Initialize the build environment variables
source build/envsetup.sh

# Clean up the previous target files safely before compiling
make installclean

# Run the build using Brunch mode
brunch mh2lm
