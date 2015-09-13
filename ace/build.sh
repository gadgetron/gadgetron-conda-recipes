#!/usr/bin/env bash

export ACE_ROOT=`pwd`

if [ ! -d $PREFIX/lib ]; then
    mkdir $PREFIX/lib
fi

if [ `uname` == Darwin ]; then
    # How do we know what system we are on?
    echo "#include \"ace/config-macosx-mavericks.h\"" > ace/config.h
    echo "include \$(ACE_ROOT)/include/makeinclude/platform_macosx_mavericks.GNU" > include/makeinclude/platform_macros.GNU 
fi

if [ `uname` == Linux ]; then
    echo "#include \"ace/config-linux.h\"" > ace/config.h
    echo "include \$(ACE_ROOT)/include/makeinclude/platform_linux.GNU" > include/makeinclude/platform_macros.GNU
fi

make -j4 -C ace -f GNUmakefile.ACE INSTALL_PREFIX=$PREFIX LDFLAGS="" DESTDIR="" INST_DIR="/ace" debug=0 shared_libs=1 static_libs=0 install



