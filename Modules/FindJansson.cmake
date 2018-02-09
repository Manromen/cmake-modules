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

# FindJansson
# -----------
#
#  Try to find the Jansson library
#
#
#  This module defines the following variables::
# 
#  JANSSON_FOUND       - Jansson was found
#  JANSSON_INCLUDE_DIR - Include directories for Jansson
#  JANSSON_LIBRARIES   - Libraries of Jansson
#
#
#   This module accepts the following variables::
#
#  JANSSON_ROOT        - Preferred installation prefix
# 

include(FindPackageHandleStandardArgs)

# check if jansson variables are already set
if(NOT JANSSON_INCLUDE_DIR OR NOT JANSSON_LIBRARIES)

    # set include paths that need to be searched for header files
    set(INCLUDE_PATHS ${JANSSON_ROOT}/include /usr/include /usr/local/include)
    # set library paths that need to be searched for library files
    set(LIBRARY_PATHS ${JANSSON_ROOT}/lib /usr/lib /usr/local/lib)

    # search for jansson.h
    find_path(JANSSON_INCLUDE_DIR NAMES jansson.h PATHS ${INCLUDE_PATHS})
    # search for jansson and libjansson
    find_library(JANSSON_LIBRARIES NAMES jansson libjansson PATHS ${LIBRARY_PATHS})

    # check if the library was found
    if(JANSSON_INCLUDE_DIR AND JANSSON_LIBRARIES)

        # set include and library variables for jansson
        set(JANSSON_INCLUDE_DIR ${JANSSON_INCLUDE_DIR} CACHE STRING "The include paths needed for jansson.")
        set(JANSSON_LIBRARIES ${JANSSON_LIBRARIES} CACHE STRING "The libraries needed by jansson.")

        # don't show these variables in cmake gui
        mark_as_advanced(JANSSON_INCLUDE_DIR JANSSON_LIBRARIES)

    endif(JANSSON_INCLUDE_DIR AND JANSSON_LIBRARIES)
endif(NOT JANSSON_INCLUDE_DIR OR NOT JANSSON_LIBRARIES)

# handle the QUIETLY and REQUIRED arguments and set JANSSON_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(Jansson DEFAULT_MSG
                                  JANSSON_LIBRARIES JANSSON_INCLUDE_DIR)

