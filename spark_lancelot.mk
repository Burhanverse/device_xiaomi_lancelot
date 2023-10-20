#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from device makefile.
$(call inherit-product, device/xiaomi/lancelot/device.mk)

# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/spark/config/common_full_phone.mk)

# Device props
TARGET_ENABLE_BLUR := true
TARGET_FACE_UNLOCK_SUPPORTED := true
TARGET_SUPPORTS_QUICK_TAP := true

# Bootanimation Resolution
TARGET_BOOT_ANIMATION_RES := 1080

# Charging
TARGET_USE_PIXEL_CHARGER := true
TARGET_SUPPORTS_ADAPTIVE_CHARGING := true

# Device identifier. This must come after all inclusions.
PRODUCT_NAME := spark_lancelot
PRODUCT_DEVICE := lancelot
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_BRAND := Redmi
PRODUCT_MODEL := Redmi 9

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="lancelot-user 11 RP1A.200720.011 V12.5.8.0.RJCCNXM release-keys"

BUILD_FINGERPRINT := Redmi/lancelot_global/lancelot:11/RP1A.200720.011/V12.5.8.0.RJCCNXM:user/release-keys
