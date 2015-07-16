#!/bin/bash

mkdir build
cd build

if [ `uname` == Darwin ]; then

    MACOSX_VERSION_MIN=10.8
    CXXFLAGS="-mmacosx-version-min=${MACOSX_VERSION_MIN}"
    LINKFLAGS="-mmacosx-version-min=${MACOSX_VERSION_MIN} "

    #ARMA_LIB="libarmadillo.dylib"
    #PY_LIB="libpython2.7.dylib"
    
    cmake \
	-D CMAKE_OSX_DEPLOYMENT_TARGET="10.8" \
        -D CMAKE_INSTALL_PREFIX="${PREFIX}" ..

    #    \
#	-D CMAKE_BUILD_TYPE=Debug                              \
#	-D CMAKE_CXX_FLAGS="${CXXFLAGS}"                       \
#	-D CMAKE_SHARED_LINKER_FLAGS="${LINKFLAGS}"            \
#	-D BOOST_ROOT="${PREFIX}/lib"                          \
#       -D ARMADILLO_LIBRARY="${PREFIX}/lib/${ARMA_LIB}"       \
#       -D ARMADILLO_INCLUDE_DIR="${PREFIX}/include/"          \
#	-D PYTHON_EXECUTABLE="$PREFIX/bin/python"              \
#	-D PYTHON_INCLUDE_DIR="$PREFIX/include/python2.7/"     \
#	-D PYTHON_LIBRARY="$PREFIX/lib/${PY_LIB}"              \

fi

if [ `uname` == Linux ]; then
    PY_LIB="libpython2.7.so"
fi

make
make install


