include $(call first-makefiles-under,$(LOCAL_PATH))

PRODUCT_COPY_FILES += \
    vendor/opstuffr/etc/permissions/privapp-permissions-op-launcher.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-op-launcher.xml \
    vendor/opstuff/etc/sysconfig/op-launcher-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/op-launcher-hiddenapi-package-whitelist.xml

PRODUCT_PACKAGES += \
    OnePlusRecentsProvider \
    OPLauncher \
    OPGAllery \
    OPIconpackOxygen \
    OPIconpackRound \
    OPWidget
