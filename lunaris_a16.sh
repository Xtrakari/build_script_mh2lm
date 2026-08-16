rm -rf .repo/local_manifests/

repo init -u https://github.com/Lunaris-AOSP/android -b 16.2 --git-lfs --depth=1

git clone https://github.com/Xtrakari/local_manifest_mh2lm.git --depth 1 -b mh2lm-lunaris16 .repo/local_manifests

/opt/crave/resync.sh

source build/envsetup.sh

lunch lineage_mh2lm-bp4a-userdebug

m bacon
