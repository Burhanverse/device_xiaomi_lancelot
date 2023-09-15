LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := RemovePackages
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_TAGS := optional
LOCAL_OVERRIDES_PACKAGES := \
    bcr \
    FMRadio \
    AndroidAutoStubPrebuilt \
    AmbientSensePrebuilt \
    CalculatorGooglePrebuilt \
    CalendarGooglePrebuilt \
    Chrome-Stub \
    DeskClock \
    Drive \
    Eleven \
    Etar \
    ExactCalculator \
    yetCalc \
    Gallery2 \
    Jelly \
    MaestroPrebuilt \
    MatLog \
    Maps \
    Gmail2 \
    PersonalSafety \
    Photos \
    PrebuiltDeskClockGoogle \
    Recorder \
    RecorderPrebuilt \
    SafetyHubPrebuilt \
    Snap \
    Turbo \
    TurboPrebuilt \
    TipsPrebuilt \
    Velvet \
    YouTube
    
LOCAL_UNINSTALLABLE_MODULE := true
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_SRC_FILES := /dev/null
include $(BUILD_PREBUILT)
