#!/bin/sh
######################
# Options
######################

REVEAL_ARCHIVE_IN_FINDER=false

FRAMEWORK_NAME="${PROJECT_NAME}"

SIMULATOR_LIBRARY_PATH="${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${FRAMEWORK_NAME}.framework"

DEVICE_LIBRARY_PATH="${BUILD_DIR}/${CONFIGURATION}-iphoneos/${FRAMEWORK_NAME}.framework"

UNIVERSAL_LIBRARY_DIR="${BUILD_DIR}/${CONFIGURATION}-iphoneuniversal"

FRAMEWORK="${UNIVERSAL_LIBRARY_DIR}/${FRAMEWORK_NAME}.framework"


######################
# Build Frameworks
######################

xcodebuild -project "${PROJECT_FILE_PATH}" -target "${TARGET_NAME}"
ONLY_ACTIVE_ARCH=NO -configuration "${CONFIGURATION}" -sdk iphonesimulator
BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}" BUILD_ROOT="${BUILD_ROOT}"
CONFIGURATION_BUILD_DIR="${IPHONE_SIMULATOR_BUILD_DIR}" SYMROOT="${SYMROOT}"
ARCHS="i386 x86_64" ENABLE_BITCODE=YES OTHER_CFLAGS="-fembed-bitcode" $ACTION 2>&1

xcodebuild -project "${PROJECT_FILE_PATH}" -target "${TARGET_NAME}"
ONLY_ACTIVE_ARCH=NO -configuration "${CONFIGURATION}" -sdk iphoneos
BUILD_DIR="${BUILD_DIR}" OBJROOT="${OBJROOT}" BUILD_ROOT="${BUILD_ROOT}"
CONFIGURATION_BUILD_DIR="${IPHONE_DEVICE_BUILD_DIR}" SYMROOT="${SYMROOT}"
ARCHS="armv7 armv7s arm64" ENABLE_BITCODE=YES OTHER_CFLAGS="-fembed-bitcode" $ACTION 2>&1

######################
# Create directory for universal
######################

rm -rf "${UNIVERSAL_LIBRARY_DIR}"

mkdir "${UNIVERSAL_LIBRARY_DIR}"

mkdir "${FRAMEWORK}"


######################
# Copy files Framework
######################

cp -r "${DEVICE_LIBRARY_PATH}/." "${FRAMEWORK}"


######################
# Make an universal binary
######################

lipo "${SIMULATOR_LIBRARY_PATH}/${FRAMEWORK_NAME}" "${DEVICE_LIBRARY_PATH}/${FRAMEWORK_NAME}" -create -output "${FRAMEWORK}/${FRAMEWORK_NAME}" | echo

# For Swift framework, Swiftmodule needs to be copied in the universal framework
if [ -d "${SIMULATOR_LIBRARY_PATH}/Modules/${FRAMEWORK_NAME}.swiftmodule/" ]; then
cp -f ${SIMULATOR_LIBRARY_PATH}/Modules/${FRAMEWORK_NAME}.swiftmodule/* "${FRAMEWORK}/Modules/${FRAMEWORK_NAME}.swiftmodule/" | echo
                                                                      fi

                                                                      if [ -d "${DEVICE_LIBRARY_PATH}/Modules/${FRAMEWORK_NAME}.swiftmodule/" ]; then
                                                                      cp -f ${DEVICE_LIBRARY_PATH}/Modules/${FRAMEWORK_NAME}.swiftmodule/* "${FRAMEWORK}/Modules/${FRAMEWORK_NAME}.swiftmodule/" | echo
                                                                      fi

                                                                      ######################
                                                                      # On Release, copy the result to release directory
                                                                      ######################
                                                                      OUTPUT_DIR="${PROJECT_DIR}/Output/${FRAMEWORK_NAME}-${CONFIGURATION}-iphoneuniversal/"

                                                                      rm -rf "$OUTPUT_DIR"
                                                                      mkdir -p "$OUTPUT_DIR"

                                                                      cp -r "${FRAMEWORK}" "$OUTPUT_DIR"

                                                                      if [ ${REVEAL_ARCHIVE_IN_FINDER} = true ]; then
                                                                      open "${OUTPUT_DIR}/"
                                                                      fi

