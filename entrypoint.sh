#!/bin/sh

# Args
# $1 paths to the unit test projects, delimited by ;

# Split the delimited string into an array of paths
IFS=';' read -ra paths <<< "$1"
for i in "${paths[@]}"; do
  echo "$i"
done

# Record starting directory
project_root="$PWD"

# The following will need to wrapped so that multiple unit test
# projects can be iterated through

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
