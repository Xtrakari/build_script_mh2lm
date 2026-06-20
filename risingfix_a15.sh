# repo sync
/opt/crave/resync.sh

# Initialize the build environment variables
source build/envsetup.sh

# 2. FIXED: Changed 'userdebug' to match standard riseup format
riseup mh2lm

gk -s

# Standard compile command
rise b
