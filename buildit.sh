#!/bin/bash

CHANNEL=inati
PY_VER=3.5
NPY_VER=1.9

# Note, these are in the order in which they need to be built
# for a clean setup.
DEPS='ismrmrd
      gadgetron-base
      ismrmrd-python
      ismrmrd-python-tools
      siemens_to_ismrmrd'

# Rebuild the dependencies and upload as needed
echo "Collecting dependencies"
conda build --python ${PY_VER} --numpy ${NPY_VER} \
  --skip-existing --override-channels -c ${CHANNEL} -c defaults ${DEPS}

# Build the metapackage and force upload
echo "Assembling package"
conda build --python ${PY_VER} --numpy ${NPY_VER} \
  --override-channels -c ${CHANNEL} -c defaults gadgetron

echo "All done!"