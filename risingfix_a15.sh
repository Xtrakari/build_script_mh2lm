# Initialize the build environment variables
source build/envsetup.sh

# Lunch 
riseup mh2lm userdebug

# Clean up the previous target files safely before compiling
make installclean

# Build 
rise b
