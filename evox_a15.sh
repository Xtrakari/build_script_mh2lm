#!/bin/bash

# Clean out any old local manifests
rm -rf .repo/local_manifests/
echo "=============================="
echo "Cleaned old local manifests"
echo "=============================="

# Repo init Evolution X (udc branch)
repo init -u https://github.com/Evolution-X/manifest -b vic --git-lfs --depth=1
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Xtrakari/local_manifest_mh2lm.git .repo/local_manifests -b main
echo "============================"
echo "Local manifest clone success"
echo "============================"

echo "================================"
echo "Local manifest creation success"
echo "================================"

# Build Sync using Crave's infrastructure script
/opt/crave/resync.sh 
echo "============="
echo "Sync success"
echo "============="

# Clone Evolution X Private Keys template
rm -rf vendor/evolution-priv/keys
git clone https://github.com/Evolution-X/vendor_evolution-priv_keys-template vendor/evolution-priv/keys
echo "============================="
echo "Keys template clone success"
echo "============================="

# Generate Signature Keys non-interactively
# (Pipes 'enter' keypresses to skip manual inputs/prompts in the script)
cd vendor/evolution-priv/keys
printf '\n\n\n\n\n\n\n\n' | ./keys.sh
cd ../../..
echo "============================="
echo "Inline Key Generation Success"
echo "============================="

# Set Custom Build Directory & Flags
export OUT_DIR_COMMON_BASE=/home/crave/out
export BUILD_USERNAME=Xtra
export BUILD_HOSTNAME=crave
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
echo "======================="
echo "Build Environment Exported"
echo "======================="

# Set up build environment
source build/envsetup.sh
echo "============================"
echo "Environment Setup Completed"
echo "============================"

# Lunch command for LGE V50S on Evolution X
lunch lineage_mh2lm-userdebug
echo "============="
echo "Lunch Success"
echo "============="

# Compile the target image 
# (No thread cap like -j24 so Crave spins up at maximum server capacity)
m evolution
