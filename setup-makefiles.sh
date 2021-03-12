#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=common
VENDOR=opstuff

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" true

# Warning headers and guards
write_headers "arm64"
sed -i 's|TARGET_DEVICE|TARGET_ARCH|g' "${ANDROIDMK}"
sed -i 's|vendor/opstuff/|vendor/opstuff/common|g' "${PRODUCTMK}"
sed -i 's|device/opstuff//setup-makefiles.sh|vendor/opstuff/setup-makefiles.sh|g' "${ANDROIDBP}" "${ANDROIDMK}" "${BOARDMK}" "${PRODUCTMK}"


write_makefiles "${MY_DIR}/proprietary-files.txt" true

overrides=" \
    OPLauncher:Launcher3QuickStep,TrebuchetQuickStep \
    OPGallery:Gallery2,PhotoTable,SnapdragonGallery"

for i in ${overrides[@]}; do
  # Split the string into var1 and var2
  IFS=: read var1 var2 <<< $i

  # Get the line number to insert the override
  line_number=$(grep -rn "name: \"$var1\"" "${ANDROIDBP}" | awk '{print $1}' | tr -d ":")

  # Split the replacement in override1, override2 and override3
  IFS=, read override1 override2 override3 <<< $var2

  # Insert one or two replacements
  if [[ "${override3}" != "" ]]; then
    # Insert the override for three replacements
    sed -i "${line_number} a \\\toverrides: [\"${override1}\", \"${override2}\", \"${override3}\"]," "${ANDROIDBP}"
elif [[ ${override2} != "" ]]; then
    # Insert the override for two replacements
    sed -i "${line_number} a \\\toverrides: [\"${override1}\", \"${override2}\"]," "${ANDROIDBP}"
  else
    # Insert the override for one replacement
    sed -i "${line_number} a \\\toverrides: [\"${override1}\"]," "${ANDROIDBP}"
  fi

done

# Finish
write_footers
