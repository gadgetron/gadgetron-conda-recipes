#!/bin/bash

mkdir build
cd build

if [ `uname` == Darwin ]; then

    MACOSX_VERSION_MIN=10.8

    CXXFLAGS="-mmacosx-version-min=${MACOSX_VERSION_MIN}"
    CXXFLAGS="${CXXFLAGS} -std=c++11 -stdlib=libc++"
    LINKFLAGS="-mmacosx-version-min=${MACOSX_VERSION_MIN} "
    LINKFLAGS="${LINKFLAGS} -stdlib=libc++ -L${PREFIX}/lib"

    cmake -D CMAKE_OSX_DEPLOYMENT_TARGET="${MACOSX_VERSION_MIN}" \
	-D CMAKE_CXX_FLAGS="${CXXFLAGS}" \
	-D CMAKE_SHARED_LINKER_FLAGS="${LINKFLAGS}" \
	-D BOOST_ROOT="${PREFIX}/lib" \
        -D BUILD_DYNAMICT=YES \
        -D CMAKE_INSTALL_PREFIX="${PREFIX}" ..
fi

if [ `uname` == Linux ]; then
    cmake -D BUILD_DYNAMICT=YES \
        -D CMAKE_INSTALL_PREFIX=$PREFIX ..
fi

make
make install


