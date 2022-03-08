#!/bin/bash

set -euo pipefail

mkdir -p build
cd build
cmake -GNinja -DCMAKE_BUILD_TYPE=Release -DCPR_FORCE_USE_SYSTEM_CURL=ON -DCMAKE_INSTALL_PREFIX=${PREFIX} ../
ninja
ninja install
