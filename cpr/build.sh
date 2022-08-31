#!/bin/bash

set -euo pipefail

mkdir -p build
cd build
if [[ $(uname) =~ Darwin ]]; then
   cmake -GNinja -DCMAKE_BUILD_TYPE=Release -DCPR_FORCE_USE_SYSTEM_CURL=OFF -CMAKE_C_COMPILER=${CONDA_PREFIX}/bin/clang -CMAKE_CXX_COMPILER=${CONDA_PREFIX}/bin/clang++ -DCMAKE_INSTALL_PREFIX=${PREFIX} ../
else
   cmake -GNinja -DCMAKE_BUILD_TYPE=Release -DCPR_FORCE_USE_SYSTEM_CURL=ON  -DCMAKE_INSTALL_PREFIX=${PREFIX} ../
fi
ninja
ninja install
