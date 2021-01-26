LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := OPLauncher
LOCAL_MODULE_STEM := OpLauncher.apk
LOCAL_SRC_FILES := OpLauncher.apk
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT)/priv-app/OPLauncher
LOCAL_OVERRIDES_PACKAGES := ParanoidQuickStep Launcher3QuickStep Launcher3 PixelLauncher NexusLauncherRelease TrebuchetQuickStep

include $(BUILD_PREBUILT)
