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

# FindCNats
# -----------
#
#  Try to find the C NATS library - https://github.com/nats-io/cnats
#
#
#  This module defines the following variables::
# 
#  CNATS_FOUND       - NATS was found
#  CNATS_INCLUDE_DIR - Include directories for NATS
#  CNATS_LIBRARIES   - Libraries of NATS
#
#
#   This module accepts the following variables::
#
#  CNATS_ROOT        - Preferred installation prefix
# 

include(FindPackageHandleStandardArgs)

# check if cnats variables are already set
if(NOT CNATS_INCLUDE_DIR OR NOT CNATS_LIBRARIES)

    # set include paths that need to be searched for header files
    set(INCLUDE_PATHS ${CNATS_ROOT}/include /usr/include /usr/local/include)
    # set library paths that need to be searched for library files
    set(LIBRARY_PATHS ${CNATS_ROOT}/lib /usr/lib /usr/local/lib)

    # search for nats/nats.h nats/status.h and nats/version.h
    find_path(CNATS_INCLUDE_DIR NAMES nats/nats.h nats/status.h nats/version.h PATHS ${INCLUDE_PATHS})
    # search for nats and libnats
    find_library(CNATS_LIBRARIES NAMES nats libnats PATHS ${LIBRARY_PATHS})

    # check if the library was found
    if(CNATS_INCLUDE_DIR AND CNATS_LIBRARIES)

        # set include and library variables for cnats
        set(CNATS_INCLUDE_DIR ${CNATS_INCLUDE_DIR} CACHE STRING "The include paths needed for cnats.")
        set(CNATS_LIBRARIES ${CNATS_LIBRARIES} CACHE STRING "The libraries needed by cnats.")

        # don't show these variables in cmake gui
        mark_as_advanced(CNATS_INCLUDE_DIR CNATS_LIBRARIES)

    endif(CNATS_INCLUDE_DIR AND CNATS_LIBRARIES)
endif(NOT CNATS_INCLUDE_DIR OR NOT CNATS_LIBRARIES)

# handle the QUIETLY and REQUIRED arguments and set CNATS_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(CNats DEFAULT_MSG
    CNATS_LIBRARIES CNATS_INCLUDE_DIR)
