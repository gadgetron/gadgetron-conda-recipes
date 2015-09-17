#!/usr/bin/env bash

unzip gtest-1.7.0-zip
cd gtest-1.7.0 

mkdir build
cd build


if [ `uname` == Darwin ]; then
    cmake \
        -DCMAKE_FIND_ROOT_PATH=$PREFIX \
        -DCMAKE_OSX_DEPLOYMENT_TARGET=10.8                                      \
        -DCMAKE_CXX_FLAGS="-mmacosx-version-min=10.8 -std=c++11 -stdlib=libc++" \
        -DCMAKE_SHARED_LINKER_FLAGS="-mmacosx-version-min=10.8 -stdlib=libc++"  \
        -DCMAKE_INSTALL_PREFIX="${PREFIX}" ..
fi

if [ `uname` == Linux ]; then
    cmake \
        -DCMAKE_FIND_ROOT_PATH=$PREFIX \
        -DCMAKE_INSTALL_PREFIX="${PREFIX}" ..
fi

make

mkdir -p $PREFIX/lib
mkdir -p $PREFIX/include
cp libgtest.a libgtest_main.a $PREFIX/lib
cp -r ../include/gtest $PREFIX/include/gtest

cd ..
rm -rf build

