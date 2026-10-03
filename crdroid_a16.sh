rm -rf .repo/local_manifests/

rm -rf prebuilt/gcc

repo init -u https://github.com/crdroidandroid/android.git -b 16.0 --git-lfs --no-clone-bundle --depth=1

git clone https://github.com/Xtrakari/local_manifest_mh2lm.git --depth 1 -b mh2lm-crdroid17 .repo/local_manifests

/opt/crave/resync.sh

source build/envsetup.sh

brunch mh2lm

mka bacon
