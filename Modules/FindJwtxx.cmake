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

# FindJwtxx
# -----------
#
#  Try to find the jwtxx library - https://github.com/madf/jwtxx
#
#
#  This module defines the following variables::
# 
#  JWTXX_FOUND       - jwtxx was found
#  JWTXX_INCLUDE_DIR - Include directories for jwtxx
#  JWTXX_LIBRARIES   - Libraries of jwtxx
#
#
#   This module accepts the following variables::
#
#  JWTXX_ROOT        - Preferred installation prefix
# 

include(FindPackageHandleStandardArgs)

# check if jwtxx variables are already set
if(NOT JWTXX_INCLUDE_DIR OR NOT JWTXX_LIBRARIES)

    # set include paths that need to be searched for header files
    set(INCLUDE_PATHS ${JWTXX_ROOT}/include /usr/include /usr/local/include)
    # set library paths that need to be searched for library files
    set(LIBRARY_PATHS ${JWTXX_ROOT}/lib /usr/lib /usr/local/lib)

    # search for jwtxx/jwt.h
    find_path(JWTXX_INCLUDE_DIR NAMES jwtxx/jwt.h PATHS ${INCLUDE_PATHS})
    # search for jwtxx and libjwtxx
    find_library(JWTXX_LIBRARIES NAMES jwtxx libjwtxx PATHS ${LIBRARY_PATHS})

    # check if the library was found
    if(JWTXX_INCLUDE_DIR AND JWTXX_LIBRARIES)

        # set include and library variables for jwtxx
        set(JWTXX_INCLUDE_DIR ${JWTXX_INCLUDE_DIR} CACHE STRING "The include paths needed for jwtxx.")
        set(JWTXX_LIBRARIES ${JWTXX_LIBRARIES} CACHE STRING "The libraries needed by jwtxx.")

        # don't show these variables in cmake gui
        mark_as_advanced(JWTXX_INCLUDE_DIR JWTXX_LIBRARIES)

    endif(JWTXX_INCLUDE_DIR AND JWTXX_LIBRARIES)
endif(NOT JWTXX_INCLUDE_DIR OR NOT JWTXX_LIBRARIES)

# handle the QUIETLY and REQUIRED arguments and set JWTXX_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(Jwtxx DEFAULT_MSG
                                  JWTXX_LIBRARIES JWTXX_INCLUDE_DIR)
