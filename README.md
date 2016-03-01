# Bluedroid build #

[![License](http://img.shields.io/:license-mit-blue.svg)](LICENSE.md)

Standalone Bluedroid build 

* This is useful if you already have Bluedroid dependencies and just want to work in a different project without requiring the full AOSP source

* This project pulls only the necessary modules for the required headers

* A script will take care of retrieving the prebuilt static/shared dependency libraries necessary to build the lib from your AOSP output directory

* Only `android-5.1.1_r30`

<hr/>

## Build process

1) Initialize submodules :
```
git submodule init
git submodule update
git submodule foreach git checkout android-5.1.1_r30
```

2) Setup build :
```
source ./build/envsetup.sh
lunch
```

3) Retrieve your prebuilt static/shared library and `acp` command from your `PRODUCT_NAME` directory :
```
./get_dependencies.sh $(OUT_DIR) $(PRODUCT_DIR) $(HOST_ARCH)
```
Complete example : `./get_dependencies.sh ~/AOSP/out ~/AOSP/out/target/product/HMB4213H linux-x86`
* `OUT_DIR`     : the AOSP output directory (for instance ~/AOSP/out)
* `PRODUCT_DIR` : product directory (for instance ~/AOSP/out/target/product/HMB4213H)
* `HOST_ARCH`   : your host arch (for instance linux-x86)

4) Build Bludroid :
```
cd bluedroid
mm
```

Output is located in `out/target/product/generic/system/lib/hw/` : `audio.a2dp.default.so` and `bluetooth.default.so`

## Required dependencies

### Static libraries

* `$(PRODUCT_DIR)/obj/STATIC_LIBRARIES/libcompiler_rt-extras_intermediates`
* `$(PRODUCT_DIR)/obj/STATIC_LIBRARIES/libgtest_intermediates`
* `$(PRODUCT_DIR)/obj/STATIC_LIBRARIES/libgtest_main_intermediates`
* `$(PRODUCT_DIR)/obj/STATIC_LIBRARIES/libstdc++_intermediates`
* `$(PRODUCT_DIR)/obj/STATIC_LIBRARIES/libtinyxml2_intermediates`

### Shared libraries

* `$(PRODUCT_DIR)/obj/SHARED_LIBRARIES/libc_intermediates`
* `$(PRODUCT_DIR)/obj/SHARED_LIBRARIES/libcutils_intermediates`
* `$(PRODUCT_DIR)/obj/SHARED_LIBRARIES/libdl_intermediates`
* `$(PRODUCT_DIR)/obj/SHARED_LIBRARIES/libhardware_intermediates`
* `$(PRODUCT_DIR)/obj/SHARED_LIBRARIES/libhardware_legacy_intermediates`
* `$(PRODUCT_DIR)/obj/SHARED_LIBRARIES/liblog_intermediates`
* `$(PRODUCT_DIR)/obj/SHARED_LIBRARIES/libm_intermediates`
* `$(PRODUCT_DIR)/obj/SHARED_LIBRARIES/libpower_intermediates`
* `$(PRODUCT_DIR)/obj/SHARED_LIBRARIES/libstdc++_intermediates`
* `$(PRODUCT_DIR)/obj/SHARED_LIBRARIES/libstlport_intermediates`
* `$(PRODUCT_DIR)/obj/SHARED_LIBRARIES/libutils_intermediates`

<hr/>

* `$(PRODUCT_DIR)/obj/lib/crtbegin_dynamic.o`
* `$(PRODUCT_DIR)/obj/lib/crtbegin_so.o`
* `$(PRODUCT_DIR)/obj/lib/crtend_android.o`
* `$(PRODUCT_DIR)/obj/lib/crtend_so.o`
* `$(PRODUCT_DIR)/obj/lib/libc.so`
* `$(PRODUCT_DIR)/obj/lib/libcutils.so`
* `$(PRODUCT_DIR)/obj/lib/libdl.so`
* `$(PRODUCT_DIR)/obj/lib/libhardware.so`
* `$(PRODUCT_DIR)/obj/lib/libhardware_legacy.so`
* `$(PRODUCT_DIR)/obj/lib/liblog.so`
* `$(PRODUCT_DIR)/obj/lib/libm.so`
* `$(PRODUCT_DIR)/obj/lib/libpower.so`
* `$(PRODUCT_DIR)/obj/lib/libstdc++.so`
* `$(PRODUCT_DIR)/obj/lib/libstlport.so`
* `$(PRODUCT_DIR)/obj/lib/libutils.so`

### host binaries

* `$(OUT_DIR)/host/$(HOST_ARCH)/bin/acp`

## Submodules

|          Path          |   Repository     |
|------------------------|------------------|
|   build                | https://android.googlesource.com/platform/build |
|   bionic               | https://android.googlesource.com/platform/bionic |
|   system/core          | https://android.googlesource.com/platform/system/core |
|   prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.8 | https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.8 |
|   bluedroid            | https://android.googlesource.com/platform/external/bluetooth/bluedroid |
|   hardware/libhardware          |  https://android.googlesource.com/platform/hardware/libhardware |
|   external/gtest       | https://android.googlesource.com/platform/external/gtest |
|   external/stlport     | https://android.googlesource.com/platform/external/stlport |
|   external/tinyxml2    | https://android.googlesource.com/platform/external/tinyxml2 |