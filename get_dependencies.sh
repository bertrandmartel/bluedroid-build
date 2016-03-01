#!/bin/bash

function show_usage() {
	echo "usage : ./get_dependencies.sh \$(OUT_DIR) \$(PRODUCT_DIR) \$(HOST_ARCH)"
	echo "OUT_DIR     : the AOSP output directory (for instance ~/AOSP/out)"
	echo "PRODUCT_DIR : product directory (for instance ~/AOSP/out/target/product/HMB4213H)"
	echo "HOST_ARCH   : your host arch (for instance linux-x86)"
}

if [ -z $1 ] ||  [ -z $2 ] ||  [ -z $3 ]; then
	show_usage
	exit
fi

OUT_DIR="$1"
PRODUCT_DIR="$2"
HOST_ARCH="$3"

if [ ! -d "$1" ]; then
	echo "Error ${OUT_DIR} directory not found"
	show_usage
	exit
fi
if [ ! -d "$2" ]; then
	echo "Error ${PRODUCT_DIR} directory not found"
	show_usage
	exit
fi

if [ ! -d "${OUT_DIR}/host/${HOST_ARCH}/bin" ]; then
	echo "${OUT_DIR}/host/${HOST_ARCH}/bin not found"
	exit
fi

declare -a DEPENDENCY_HOST_BINARIES=("acp")

declare -a DEPENDENCY_SHARED_LIBRARIES_DIRECTORY=("libc" "libcutils" \
	"libdl"     "libhardware" "libhardware_legacy" \
	"liblog"    "libm"        "libpower" \
	"libstdc++" "libstlport"  "libutils")

declare -a DEPENDENCY_STATIC_LIBRARIES_DIRECTORY=("libcompiler_rt-extras" "libgtest" \
	"libgtest_main" "libstdc++" "libtinyxml2")

declare -a DEPENDENCY_STATIC_LIBRARIES_FILES=("crtbegin_dynamic.o"     "crtbegin_so.o" "crtend_android.o" "crtend_so.o" \
"libc.so"                "libcutils.so"  "libdl.so"         "libhardware.so" \
"libhardware_legacy.so"  "liblog.so"     "libm.so"          "libpower.so" \
"libstdc++.so"           "libstlport.so" "libutils.so")

OBJECT_DIR="out/target/product/generic/obj"
BIN_DIR="out/host/${HOST_ARCH}/bin"

mkdir -p ${OBJECT_DIR}/{SHARED_LIBRARIES,STATIC_LIBRARIES,lib}
mkdir -p ${BIN_DIR}

for file in "${DEPENDENCY_HOST_BINARIES[@]}"
do
	if [ ! -f "${OUT_DIR}/host/${HOST_ARCH}/bin/$file" ]; then
		echo "host binary ${OUT_DIR}/host/${HOST_ARCH}/bin/$file not found"
		exit
	else
		cp --no-clobber ${OUT_DIR}/host/${HOST_ARCH}/bin/$file ${BIN_DIR}/
	fi
done

for directory in "${DEPENDENCY_SHARED_LIBRARIES_DIRECTORY[@]}"
do
	if [ ! -d "${PRODUCT_DIR}/obj/SHARED_LIBRARIES/${directory}_intermediates" ]; then
		echo "shared library directory ${PRODUCT_DIR}/obj/SHARED_LIBRARIES/${directory}_intermediates not found"
		exit
	else
		cp -r --no-clobber ${PRODUCT_DIR}/obj/SHARED_LIBRARIES/${directory}_intermediates ${OBJECT_DIR}/SHARED_LIBRARIES/
	fi
done

for directory in "${DEPENDENCY_STATIC_LIBRARIES_DIRECTORY[@]}"
do
	if [ ! -d "${PRODUCT_DIR}/obj/STATIC_LIBRARIES/${directory}_intermediates" ]; then
		echo "static library directory ${PRODUCT_DIR}/obj/STATIC_LIBRARIES/${directory}_intermediates not found"
		exit
	else
		cp -r --no-clobber ${PRODUCT_DIR}/obj/STATIC_LIBRARIES/${directory}_intermediates ${OBJECT_DIR}/STATIC_LIBRARIES/
	fi
done

for file in "${DEPENDENCY_STATIC_LIBRARIES_FILES[@]}"
do
	if [ ! -f "${PRODUCT_DIR}/obj/lib/${file}" ]; then
		echo "file ${PRODUCT_DIR}/obj/lib/${file} not found"
		exit
	else
		cp -r --no-clobber ${PRODUCT_DIR}/obj/lib/${file} ${OBJECT_DIR}/lib/
	fi
done

echo "---OK---"

