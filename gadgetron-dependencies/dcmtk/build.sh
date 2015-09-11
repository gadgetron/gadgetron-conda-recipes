#!/usr/bin/env bash

mkdir build
cd build

CC=$PREFIX/bin/gcc \
CCX=$PREFIX/bin/g++ \
cmake \
    -DCMAKE_FIND_ROOT_PATH=$PREFIX \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" ..

make -j4
make install

