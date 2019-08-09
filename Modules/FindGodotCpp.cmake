#  ---------------------------------------------------------------------------------------------------------------------
#  The MIT License (MIT)
#
#  Copyright (c) 2019 Ralph-Gordon Paul. All rights reserved.
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
#  documentation files (the "Software"), to deal in the Software without restriction, including without limitation the 
#  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to 
#  permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the 
#  Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE 
#  WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR 
#  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
#  OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#  ---------------------------------------------------------------------------------------------------------------------

# FindGodotCpp
# -----------
#
#  Try to find the Godot C++ library - https://github.com/GodotNativeTools/godot-cpp
#
#
#  This module defines the following variables::
# 
#  GODOTCPP_FOUND            - Godot C++ was found
#  GODOT_CPP_INCLUDE_DIRS    - Include directories for Godot
#  GODOT_CPP_LIBRARIES       - Libraries of Godot
#
#
#   This module accepts the following variables::
#
#  GODOT_CPP_ROOT            - Preferred installation prefix
# 

include(FindPackageHandleStandardArgs)

# check if godot variables are already set
if(NOT GODOT_CPP_INCLUDE_DIRS OR NOT GODOT_CPP_LIBRARIES)

    # set include paths that need to be searched for header files
    set(INCLUDE_PATHS "${GODOT_CPP_ROOT}/include" /usr/include /usr/local/include)
    # set library paths that need to be searched for library files
    set(LIBRARY_PATHS "${GODOT_CPP_ROOT}/lib" /usr/lib /usr/local/lib)

    # search for core/Godot.hpp
    find_path(GODOT_CPP_INCLUDE_DIR_CORE NAMES Godot.hpp PATHS ${INCLUDE_PATHS} PATH_SUFFIXES core)
    # search for gen/GDNative.hpp
    find_path(GODOT_CPP_INCLUDE_DIR_GEN NAMES GDNative.hpp PATHS ${INCLUDE_PATHS} PATH_SUFFIXES gen)
    # find base include path using core/Godot.hpp
    find_path(GODOT_CPP_INCLUDE_DIR NAMES core/Godot.hpp PATHS ${INCLUDE_PATHS})
    # search for godot_headers/gdnative_api_struct.gen.h
    find_path(GODOT_CPP_INCLUDE_DIR_API NAMES gdnative_api_struct.gen.h 
        PATHS ${INCLUDE_PATHS} 
        PATH_SUFFIXES godot_headers)

    set(GODOT_CPP_INCLUDE_DIRS 
        ${GODOT_CPP_INCLUDE_DIR} 
        ${GODOT_CPP_INCLUDE_DIR_API} 
        ${GODOT_CPP_INCLUDE_DIR_CORE} 
        ${GODOT_CPP_INCLUDE_DIR_GEN})

    # Create the correct name (godot.os.build_type.system_bits)
    set(BITS 32)
    if(CMAKE_SIZEOF_VOID_P EQUAL 8)
        set(BITS 64)
    endif(CMAKE_SIZEOF_VOID_P EQUAL 8)

    string(TOLOWER ${CMAKE_SYSTEM_NAME} SYSTEM_NAME)
    string(TOLOWER ${CMAKE_BUILD_TYPE} BUILD_TYPE)

    if(ANDROID)
        # Added the android abi after system name
        set(SYSTEM_NAME ${SYSTEM_NAME}.${ANDROID_ABI})
        # Android does not have the bits at the end if you look at the main godot repo build
    endif()

    # search for godot-cpp and libgodot-cpp
    find_library(GODOT_CPP_LIBRARIES 
        NAMES "godot-cpp.${SYSTEM_NAME}.${BUILD_TYPE}.${BITS}" "godot-cpp.${SYSTEM_NAME}.${BUILD_TYPE}"
        PATHS ${LIBRARY_PATHS})

    # check if the library was found
    if(GODOT_CPP_INCLUDE_DIRS AND GODOT_CPP_LIBRARIES)

        # set include and library variables for godot
        set(GODOT_CPP_INCLUDE_DIRS ${GODOT_CPP_INCLUDE_DIRS} CACHE STRING "The include paths needed for godot-cpp.")
        set(GODOT_CPP_LIBRARIES ${GODOT_CPP_LIBRARIES} CACHE STRING "The libraries needed by godot-cpp.")

        # don't show these variables in cmake gui
        mark_as_advanced(GODOT_CPP_INCLUDE_DIRS GODOT_CPP_LIBRARIES)

    endif(GODOT_CPP_INCLUDE_DIRS AND GODOT_CPP_LIBRARIES)
endif(NOT GODOT_CPP_INCLUDE_DIRS OR NOT GODOT_CPP_LIBRARIES)

# handle the QUIETLY and REQUIRED arguments and set GODOT_CPP_ROOT to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(GodotCpp
                                  FOUND_VAR GODOTCPP_FOUND
                                  REQUIRED_VARS GODOT_CPP_LIBRARIES GODOT_CPP_INCLUDE_DIRS)

