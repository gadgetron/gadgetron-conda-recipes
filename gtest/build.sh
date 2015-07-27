#!/usr/bin/env bash

unzip gtest-1.7.0-zip
cd gtest-1.7.0 
mkdir build
cd build

cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" ..

make -j4

mkdir -p $PREFIX/lib
mkdir -p $PREFIX/include
cp libgtest.a libgtest_main.a $PREFIX/lib
cp -r ../include/gtest $PREFIX/include/gtest

