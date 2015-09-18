#!/bin/bash

CHANNEL=inati
PY_VER=3.4
NPY_VER=1.9

PKG=gadgetron

# Figure out what we are building
BLD_STR="--python ${PY_VER} --numpy ${NPY_VER}
         --override-channels -c ${CHANNEL} -c defaults ${PKG}"
OUTPUTS=$(conda build --output $BLD_STR)

# Do it
conda build --no-anaconda-upload $BLD_STR

# Upload the results
anaconda upload --force $OUTPUTS

echo "All done!"