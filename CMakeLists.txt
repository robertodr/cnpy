# This file is autogenerated by Autocmake v1.0.0-alpha-x http://autocmake.org
# Copyright (c) 2015-2017 by Radovan Bast, Jonas Juselius, and contributors.

# set minimum cmake version
cmake_minimum_required(VERSION 3.1 FATAL_ERROR)

# project name
project(cnpy CXX)

# do not rebuild if rules (compiler flags) change
set(CMAKE_SKIP_RULE_DEPENDENCY TRUE)

# if CMAKE_BUILD_TYPE undefined, we set it to Debug
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug")
endif()

# directories which hold included cmake modules
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${PROJECT_SOURCE_DIR}/cmake/custom)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${PROJECT_SOURCE_DIR}/cmake/downloaded)

# included cmake modules
include(autocmake_cxx)
include(cxx11)
include(c99)
include(autocmake_custom_color_messages)
include(GNUdirs)
include(static_library)
include(version)
include(export_target)
include(autocmake_definitions)
include(autocmake_safeguards)
include(autocmake_default_build_paths)
include(cnpy)
include(autocmake_export_header)
include(test)
