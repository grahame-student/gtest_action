#!/bin/sh

# Args
# 1 - path to directory with test cases

# Record starting directory
project_root="$PWD"

# Build the unit tests
cp /CMakeLists.txt "$1"
cd "$1" || exit 1
cmake CMakeLists.txt
make || exit 2

# execute the unit tests
cd "$project_root" || exit 3
"./$1/unit_tests" || exit 4

# generate a coverage report
uuid=$(uuidgen)
gcovr --branches --xml-pretty -r "$project_root" >> "$uuid-report.xml"
