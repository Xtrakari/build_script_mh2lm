# Initialize the build environment variables
source build/envsetup.sh

# Setup the device
lunch lineage_mh2lm-bp1a-userdebug

# Clean up the previous target files safely before compiling
make installclean

# Run the build
mka derp

