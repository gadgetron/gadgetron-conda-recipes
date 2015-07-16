#!/usr/bin/env bash

mkdir build
cd build

if [ `uname` == Darwin ]; then
    cmake \
	-DCMAKE_OSX_DEPLOYMENT_TARGET=10.8 \
	-DCMAKE_CXX_FLAGS="-mmacosx-version-min=10.8 -std=c++11 -stdlib=libc++" \
	-DCMAKE_SHARED_LINKER_FLAGS="-mmacosx-version-min=10.8 -stdlib=libc++" \
    	-DCMAKE_INSTALL_PREFIX="${PREFIX}" ..
fi

if [ `uname` == Linux ]; then
    cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" ..
fi

make
make install

