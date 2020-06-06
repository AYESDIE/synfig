cmake_minimum_required(VERSION 2.8)

project(synfig-studio)

set(SYNFIG_BUILD_ROOT ${CMAKE_BINARY_DIR}/output)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${SYNFIG_BUILD_ROOT}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${SYNFIG_BUILD_ROOT}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${SYNFIG_BUILD_ROOT}/bin)

set(CMAKE_BUILD_TYPE Debug)

message("CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")

add_subdirectory(ETL)
include_directories(ETL)
include_directories(${PROJECT_BINARY_DIR}/ETL) # to find the generated etl_profile.h
add_subdirectory(synfig-core)

include_directories(synfig-core/src)
add_subdirectory(synfig-studio)