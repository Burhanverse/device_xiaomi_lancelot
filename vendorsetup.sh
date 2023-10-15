color="\033[0;32m"
end="\033[0m"

# Clone dependencies
echo -e "${color}Cloning dependencies...${end}"
# firmware
git clone --depth 1 https://github.com/Xiaomi-MT6768-Dev/device_xiaomi_lancelot-firmware device/xiaomi/lancelot-firmware
# vendor
git clone --depth 1 https://github.com/Xiaomi-MT6768-Dev/vendor_xiaomi_lancelot -b 14 vendor/xiaomi/lancelot
# kernel
git clone --depth 1 https://gitlab.com/MT6768Lab/KernelTree kernel/xiaomi/mt6768
# mtk sepolicy vendor
rm -rf device/mediatek/sepolicy_vndr
git clone --depth 1 https://github.com/LineageOS/android_device_mediatek_sepolicy_vndr -b 14 device/mediatek/sepolicy_vndr
# mtk hardware 
rm -rf hardware/mediatek
git clone --depth 1 https://github.com/LineageOS/android_hardware_mediatek hardware/mediatek
# clang
git clone --depth 1 https://gitlab.com/crdroidandroid/android_prebuilts_clang_host_linux-x86_clang-r487747c prebuilts/clang/host/linux-x86/clang-r487747c

echo -e "Dependencies cloned successfully!"