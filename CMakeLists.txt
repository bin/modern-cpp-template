cmake_minimum_required(VERSION 3.17)
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/vcpkg/scripts/buildsystems/vcpkg.cmake
	CACHE STRING "Vcpkg toolchain file")
project(project VERSION 0.0.1 LANGUAGES CXX)
set(VERSION "0.0.1")
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include(cmake/Settings.cmake)
include(cmake/Utils.cmake)

if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
	message(FATAL_ERROR "Cannot build in source directory.")
endif()

# Ensure exceptions are enabled
# clang-cl or MSVC
if ((${CMAKE_CXX_COMPILER_ID} STREQUAL "Clang" AND "x${CMAKE_CXX_SIMULATE_ID}" STREQUAL "xMSVC") OR CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /EHsc")
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Clang" OR CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fexceptions")
endif()

include(cmake/CompilerWarnings.cmake)
include(cmake/HeaderConfig.cmake)

add_executable(project "")

target_include_directories(project PUBLIC ${CMAKE_SOURCE_DIR}/src)
target_include_directories(project PUBLIC)

add_subdirectory(lib)
add_subdirectory(src)

include("${CMAKE_SOURCE_DIR}/cmake/clangformat-cmake/cmake/ClangFormat.cmake")
target_clangformat_setup(denanc)

if(EXISTS ${CMAKE_BINARY_DIR}/compile_commands.json)
	configure_file(${CMAKE_BINARY_DIR}/compile_commands.json ${PROJECT_SOURCE_DIR}/compile_commands.json COPYONLY)
endif()
