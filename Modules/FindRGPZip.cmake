#  ---------------------------------------------------------------------------------------------------------------------
#  The MIT License (MIT)
#
#  Copyright (c) 2018 Ralph-Gordon Paul. All rights reserved.
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

# FindRGPZip
# -----------
#
#  Try to find the RGPZip library - https://github.com/Manromen/RGPZip
#
#
#  This module defines the following variables::
# 
#  RGPZIP_FOUND           - RGPZip was found
#  RGPZIP_INCLUDE_DIR     - Include directories for RGPZip
#  RGPZIP_LIBRARIES       - Libraries of RGPZip
#  RGPZIP_VERSION         - The version of rgpzip found
#
#
#   This module accepts the following variables::
#
#  RGPZIP_ROOT            - Preferred installation prefix
# 

include(FindPackageHandleStandardArgs)

# check if rgpzip variables are already set
if(NOT RGPZIP_INCLUDE_DIR OR NOT RGPZIP_LIBRARIES)

    # set include paths that need to be searched for header files
    set(INCLUDE_PATHS "${RGPZIP_ROOT}/include" /usr/include /usr/local/include)
    # set library paths that need to be searched for library files
    set(LIBRARY_PATHS "${RGPZIP_ROOT}/lib" /usr/lib /usr/local/lib)

    # search for rgpaul/RGPZip.hpp
    find_path(RGPZIP_INCLUDE_DIR NAMES rgpaul/RGPZip.hpp PATHS ${INCLUDE_PATHS})
    # search for rgpzip and librgpzip
    find_library(RGPZIP_LIBRARIES NAMES rgpzip librgpzip PATHS ${LIBRARY_PATHS})

    # check if the library was found
    if(RGPZIP_INCLUDE_DIR AND RGPZIP_LIBRARIES)

        # set include and library variables for rgpzip
        set(RGPZIP_INCLUDE_DIR ${RGPZIP_INCLUDE_DIR} CACHE STRING "The include paths needed for rgpzip.")
        set(RGPZIP_LIBRARIES ${RGPZIP_LIBRARIES} CACHE STRING "The libraries needed by rgpzip.")

        # don't show these variables in cmake gui
        mark_as_advanced(RGPZIP_INCLUDE_DIR RGPZIP_LIBRARIES)

    endif(RGPZIP_INCLUDE_DIR AND RGPZIP_LIBRARIES)
endif(NOT RGPZIP_INCLUDE_DIR OR NOT RGPZIP_LIBRARIES)

if(RGPZIP_INCLUDE_DIR)
    if(EXISTS "${RGPZIP_INCLUDE_DIR}/rgpaul/RGPZip.hpp")
        file(STRINGS "${RGPZIP_INCLUDE_DIR}/rgpaul/RGPZip.hpp" rgpzip_version_str REGEX "^#define[\t ]+LIBRGPZIP_VERSION[\t ]+\".*\"")

        string(REGEX REPLACE "^#define[\t ]+LIBRGPZIP_VERSION[\t ]+\"([^\"]*)\".*" "\\1" RGPZIP_VERSION "${rgpzip_version_str}")
        unset(rgpzip_version_str)
    endif()
endif()

# handle the QUIETLY and REQUIRED arguments and set RGPZIP_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(RGPZip
                                  REQUIRED_VARS RGPZIP_LIBRARIES RGPZIP_INCLUDE_DIR
                                  VERSION_VAR RGPZIP_VERSION)

