# cd to the tests directory
# run
#   $cmake CMakeLists.txt
#   $make
#   $./


cmake_minimum_required(VERSION 3.10)
project(unit_tests)
 
# locate required packages
find_package(GTest REQUIRED)
find_package(Threads REQUIRED)

# pull in the GTest include files
include_directories(${GTEST_INCLUDE_DIRS})

# Recursively search for *.cpp files
file(GLOB_RECURSE unittest_SRC "*.cpp")
message(STATUS "Located *.cpp src files")
message(STATUS unittest_SRC)

# We don't want to include the 'CMakeFiles' directory, so filter it out
set (excludeDirName "CMakeLists")
set(FILTERED_SRC_FILES unittest_SRC)
message(STATUS "Copied list of *.cpp src files")
message(STATUS FILTERED_SRC_FILES)
list(FILTER FILTERED_SRC_FILES EXCLUDE REGEX "${excludeDirName}")
message(STATUS "Filtered *.cpp files")
message(STATUS FILTERED_SRC_FILES)

# define UNIT_TESTING
add_definitions(-DUNIT_TESTING)
add_definitions(-fprofile-arcs -ftest-coverage )

# define the compiler options to be used
add_compile_options(-Wall -g3 -fPIC -pthread -lgtest_main -lgtest -lpthread)

# define the executable to be generated
add_executable(unit_tests ${FILTERED_SRC_FILES})

# Link 'unit_tests' the GTest library and the pthread library
target_link_libraries(unit_tests ${GTEST_LIBRARIES} pthread gcov)
