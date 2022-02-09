#!/bin/bash

set -euo pipefail

mkdir -p build
cd build
cmake -GNinja -DCMAKE_BUILD_TYPE=Release -DCUDA_COMPUTE_CAPABILITY=ALL -DUSE_MKL=ON -DUSE_CUDA=ON -DCMAKE_INSTALL_PREFIX=${PREFIX} ../
ninja
ninja install