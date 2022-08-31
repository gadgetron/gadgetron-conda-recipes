#!/bin/bash

set -euo pipefail

mkdir -p build
cd build
if [[ $(uname) =~ Linux ]]; then
   cmake -GNinja -DCMAKE_BUILD_TYPE=Release -DCPR_FORCE_USE_SYSTEM_CURL=ON  -DCMAKE_INSTALL_PREFIX=${PREFIX} ../
else
   cmake -GNinja -DCMAKE_BUILD_TYPE=Release -DCPR_FORCE_USE_SYSTEM_CURL=OFF -DCMAKE_INSTALL_PREFIX=${PREFIX} ../
fi
ninja
ninja install
