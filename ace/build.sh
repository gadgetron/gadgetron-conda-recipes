#!/usr/bin/env bash

export ACE_ROOT=`pwd`
export LD_LIBRARY_PATH=$ACE_ROOT/lib:$LD_LIBRARY_PATH

mkdir $PREFIX/lib

if [ `uname` == Darwin ]; then
    # How do we know what system we are on?
    echo "#include \"ace/config-macosx-mavericks.h\"" > ace/config.h
    echo "INSTALL_PREFIX = $PREFIX" > include/makeinclude/platform_macros.GNU 
    echo "include \$(ACE_ROOT)/include/makeinclude/platform_macosx_mavericks.GNU" >> include/makeinclude/platform_macros.GNU 
    make -j$(sysctl -n hw.ncpu) ACE
    make -j$(sysctl -n hw.ncpu) install
fi

if [ `uname` == Linux ]; then
    echo "#include \"ace/config-linux.h\"" > ace/config.h
    echo "INSTALL_PREFIX = $PREFIX" > include/makeinclude/platform_macros.GNU 
    echo "include \$(ACE_ROOT)/include/makeinclude/platform_linux.GNU" >> include/makeinclude/platform_macros.GNU 
    CFLAGS="-fPIC"
    make -j${CPU_COUNT} ACE
    make  -j${CPU_COUNT} install
fi


