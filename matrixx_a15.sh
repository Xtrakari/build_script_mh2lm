rm -rf .repo/local_manifests/
rm -rf device/lge
rm -rf kernel/lge
rm -rf vendor/lge
rm -rf hardware/lge
rm -rf out/target/product/mh2lm
# Cleanup previous changelog to make it always fresh
rm -rf out/target/product/*/system/etc/Changelog.txt \
       out/target/product/*/obj/ETC/Changelog.txt_intermediates \
       out/target/product/*/gen/ETC/Changelog.txt_intermediates

repo init -u https://github.com/ProjectMatrixx/android -b 16.2 --depth=1 --git-lfs --no-clone-bundle

git clone https://github.com/Xtrakari/local_manifest_mh2lm.git --depth 1 -b mh2lm-matrixx16 .repo/local_manifests

/opt/crave/resync.sh

source build/envsetup.sh

lunch matrixx_mh2lm-bp4a-userdebug

make matrixx
