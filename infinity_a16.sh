rm -rf .repo/local_manifests/

repo init --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b 16 -g default,-mips,-darwin,-notdefault --depth 1

git clone https://github.com/Xtrakari/local_manifest_mh2lm.git --depth 1 -b mh2lm-infinity16 .repo/local_manifests

/opt/crave/resync.sh

source build/envsetup.sh

lunch infinity_mh2lm-userdebug

m installclean

m bacon
