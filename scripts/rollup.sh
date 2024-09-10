#! /usr/bin/env bash


HERE=`dirname "$(readlink -f "$BASH_SOURCE")"`
BUILD_DIR=$(realpath ${HERE}/../build)

if [ -d "${BUILD_DIR}" ]; then
  echo "WARNING: ${BUILD_DIR} is already exists!" >&2
  read -p "Do you confirm to delete it? [N/y] " 
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -r "${BUILD_DIR}"
  else
    echo "Aborting ..."
    exit 1
  fi
fi

mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}
cmake -DCMAKE_TOOLCHAIN_FILE=${HERE}/../cmake/toolchain.cmake ..
