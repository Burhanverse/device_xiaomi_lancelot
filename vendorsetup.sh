color="\033[0;32m"
end="\033[0m"

# Clone dependencies
echo -e "${color}Cloning dependencies..."
git clone --quiet https://github.com/Xiaomi-MT6768-Dev/proprietary_vendor_xiaomi --depth 1 vendor/xiaomi > /dev/null

rm -rf device/mediatek/sepolicy_vndr
git clone --quiet https://github.com/LineageOS/android_device_mediatek_sepolicy_vndr --depth 1 device/mediatek/sepolicy_vndr > /dev/null

rm -rf hardware/mediatek
git clone --quiet https://github.com/LineageOS/android_hardware_mediatek --depth 1 hardware/mediatek > /dev/null
echo -e "${end}"