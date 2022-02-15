#!/bin/bash

set -euo pipefail

mkdir -p build
cd build
cmake -G Ninja -DBUILD_DYNAMIC=ON -DCMAKE_C_COMPILER=$CONDA_PREFIX/bin/clang -DCMAKE_CXX_COMPILER=$CONDA_PREFIX/bin/clang++ -DCMAKE_PREFIX_PATH=${PREFIX} -DCMAKE_INSTALL_PREFIX=${PREFIX} ../
ninja
ninja install
