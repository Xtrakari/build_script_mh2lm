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

repo init -u https://github.com/RisingOS-Revived/android -b sixteen-qpr2 --depth=1 --git-lfs --no-clone-bundle

git clone https://github.com/Xtrakari/local_manifest_mh2lm.git --depth 1 -b mh2lm-rising16 .repo/local_manifests
if [ $? -ne 0 ]; then
  echo "ERROR: failed to clone local manifest"
  exit 1
fi

/opt/crave/resync.sh

source build/envsetup.sh

gk -s

riseup mh2lm userdebug

rise b
