#!/bin/bash

set -euo pipefail

mkdir -p build
cd build
cmake -GNinja -DCMAKE_C_COMPILER=$CONDA_PREFIX/bin/clang -DCMAKE_CXX_COMPILER=$CONDA_PREFIX/bin/clang++ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${PREFIX} ../
ninja
ninja install
