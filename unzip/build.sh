#!/bin/sh

# What platform?
if [[ $OSX_ARCH ]]; then
    OS="macosx"
else
    OS="generic"
fi

# The makefile mentions using the generic flag
make -f unix/Makefile generic
make -f unix/Makefile prefix=$PREFIX install

