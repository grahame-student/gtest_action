#!/bin/sh

# Args
# 1 - path to directory with test cases

# Copy CMakeLists.txt to $1
cp CMakeLists.txt "$1"
cd "$1" || exit 1
cmake CMakeLists.txt
make
ls -la
