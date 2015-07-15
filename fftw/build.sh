#!/usr/bin/env bash
# inspired by build script for Arch Linux fftw pacakge:
# https://projects.archlinux.org/svntogit/packages.git/tree/trunk/PKGBUILD?h=packages/fftw

if [`uname` == Linux ]; then
    CFLAGS="-fPIC"
fi

CONFIGURE="./configure --prefix=$PREFIX --enable-shared --enable-threads --disable-fortran --enable-openmp"

# Single precision (fftw libraries have "f" suffix)
$CONFIGURE --enable-float
make
make install

# Long double precision (fftw libraries have "l" suffix)
$CONFIGURE --enable-long-double
make
make install

# Double precision (fftw libraries have no precision suffix)
$CONFIGURE
make
make install

# Test suite
# tests are performed during building as they are not available in the
# installed package.
# Additional tests can be run with make smallcheck and make bigcheck
cd tests && make check-local
# Additional tests can be run using the next two lines
#make smallcheck
#make bigcheck
