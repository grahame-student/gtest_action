#!/bin/sh

# Args
# 1 - path to directory with test cases

# Build the unit tests
cp /CMakeLists.txt "$1"
cd "$1" || exit 1
cmake CMakeLists.txt
make

# list contents of cmakelists directory
ls -la "$1/CMakeLists"

# execute the unit tests
./unit_tests

# generate a coverage report
gcovr --branches --xml-pretty -r . >> gcovr-report.xml

# Show the resulting files
ls -la
