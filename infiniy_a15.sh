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

# Clone evox

repo init -u https://github.com/ProjectInfinity-X/manifest.git -b 15 --depth=1 --git-lfs
#Temp Fix Repo tool
#cd .repo/repo;git pull -r;cd ../..;

# Clone local_manifests repository
git clone https://github.com/Xtrakari/local_manifest_mh2lm.git --depth 1 -b mh2lm-evox .repo/local_manifests
if [ ! 0 == 0 ]
 then   curl -o .repo/local_manifests https://github.com/Xtrakari/local_manifest_mh2lm.git
 fi

# repo sync
/opt/crave/resync.sh

source build/envsetup.sh

# brunch configuration
lunch infinity_mh2lm-userdebug

# Clean
make installclean

# Run
mka bacon
