#!/bin/bash
SDK_VER=$1
CONFIG_OPT=""
INSTALL_DIR="./install_${SDK_VER}"

if [ "${SDK_VER}" = arm ]; then
	HOST=arm-linux-gnueabihf
elif [ "${SDK_VER}" = aarch64 ]; then
	HOST=aarch64-linux-gnu
elif [ "${SDK_VER}" = uclibc ]; then
	HOST=arm-cvitek-linux-uclibcgnueabihf
elif [ "${SDK_VER}" = riscv ]; then
	HOST=riscv64-unknown-linux-gnu
elif [ "${SDK_VER}" = musl ]; then
	HOST=riscv64-unknown-linux-musl
else
	echo "param error."
	exit 0
fi

make clean
./configure --target=${HOST} --host=${HOST} --build=x86_64-linux-gnu CFLAGS="-march=rv64imafdcvxthead -mabi=lp64d -mcmodel=medany -mno-ldd -g" --prefix=${INSTALL_DIR}
make -j 12
make install
exit 0
