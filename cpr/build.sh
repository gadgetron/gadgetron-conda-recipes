#!/bin/bash

set -euo pipefail

mkdir -p build
cd build
cmake -GNinja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${PREFIX} ../
ninja
ninja install