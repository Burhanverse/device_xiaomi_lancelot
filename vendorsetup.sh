color="\033[0;32m"
end="\033[0m"

# Clone dependencies
echo -e "${color}Cloning dependencies...${end}"
# vendor
git clone --depth 1 https://github.com/Xiaomi-MT6768-Dev/vendor_xiaomi_lancelot -b 14 vendor/xiaomi/lancelot
# kernel
git clone --depth 1 https://gitlab.com/MT6768Lab/KernelTree kernel/xiaomi/mt6768
# mtk sepolicy vendor
git clone --depth 1 https://github.com/Xiaomi-MT6768-Dev/device_mediatek_sepolicy_vndr device/mediatek/sepolicy_vndr
# mtk hardware 
git clone --depth 1 https://github.com/LineageOS/android_hardware_mediatek hardware/mediatek
# clang
git clone --depth 1 https://gitlab.com/crdroidandroid/android_prebuilts_clang_host_linux-x86_clang-r487747c prebuilts/clang/host/linux-x86/clang-r487747c
echo -e "Dependencies cloned successfully!"

# Configure the patches path
patchDir="device/xiaomi/lancelot/patches"

# Patch RenderEngineThreaded
echo -e "Applying RenderEngineThreaded patches!"
rm -rf frameworks/native/libs/renderengine/threaded/RenderEngineThreaded.cpp
cp ${patchDir}/frameworks/native/libs/renderengine/threaded/RenderEngineThreaded.cpp frameworks/native/libs/renderengine/threaded/

# Patch media codec issues
echo -e "Applying Media Codec patches!"
rm -rf frameworks/av/media/libstagefright/include/media/stagefright/ACodec.h
rm -rf frameworks/av/media/libstagefright/include/media/stagefright/MediaCodecSource.h
rm -rf frameworks/av/media/libstagefright/ACodec.cpp
rm -rf frameworks/av/media/libstagefright/MediaCodecSource.cpp
rm -rf frameworks/av/media/libstagefright/omx/OMXNodeInstance.cpp
rm -rf frameworks/av/media/libstagefright/omx/SimpleSoftOMXComponent.cpp
rm -rf frameworks/av/media/mediaserver/mediaserver.rc
rm -rf frameworks/av/services/mediacodec/seccomp_policy/mediaswcodec-arm.policy

cp ${patchDir}/frameworks/av/media/libstagefright/include/media/stagefright/ACodec.h frameworks/av/media/libstagefright/include/media/stagefright/
cp ${patchDir}/frameworks/av/media/libstagefright/include/media/stagefright/MediaCodecSource.h frameworks/av/media/libstagefright/include/media/stagefright/
cp ${patchDir}/frameworks/av/media/libstagefright/ACodec.cpp frameworks/av/media/libstagefright/
cp ${patchDir}/frameworks/av/media/libstagefright/MediaCodecSource.cpp frameworks/av/media/libstagefright/
cp ${patchDir}/frameworks/av/media/libstagefright/omx/OMXNodeInstance.cpp frameworks/av/media/libstagefright/omx/
cp ${patchDir}/frameworks/av/media/libstagefright/omx/SimpleSoftOMXComponent.cpp frameworks/av/media/libstagefright/omx/
cp ${patchDir}/frameworks/av/media/mediaserver/mediaserver.rc frameworks/av/media/mediaserver/
cp ${patchDir}/frameworks/av/services/mediacodec/seccomp_policy/mediaswcodec-arm.policy frameworks/av/services/mediacodec/seccomp_policy/