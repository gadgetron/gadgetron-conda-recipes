#!/usr/bin/env bash

export ACE_ROOT=`pwd`

mkdir $PREFIX/lib

if [ `uname` == Darwin ]; then
    export DYLD_LIBRARY_PATH=$ACE_ROOT/ace:$DYLD_LIBRARY_PATH
    # How do we know what system we are on?
    echo "#include \"ace/config-macosx-mavericks.h\"" > ace/config.h
    echo "include \$(ACE_ROOT)/include/makeinclude/platform_macosx_mavericks.GNU" > include/makeinclude/platform_macros.GNU 
    make -C ace -f GNUmakefile.ACE INSTALL_PREFIX=$PREFIX LDFLAGS="" DESTDIR="" INST_DIR="/ace" debug=0 shared_libs=1 static_libs=0 install
fi

if [ `uname` == Linux ]; then
    export LD_LIBRARY_PATH=$ACE_ROOT/lib:$LD_LIBRARY_PATH
    echo "#include \"ace/config-linux.h\"" > ace/config.h
    echo "INSTALL_PREFIX = $PREFIX" > include/makeinclude/platform_macros.GNU 
    echo "include \$(ACE_ROOT)/include/makeinclude/platform_linux.GNU" >> include/makeinclude/platform_macros.GNU 
    CFLAGS="-fPIC"
    make ACE
    make install
fi


