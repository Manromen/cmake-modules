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

# FindDjinni
# -----------
#
#  Try to find the djinni support library - https://github.com/dropbox/djinni
#
#
#  This module defines the following variables::
# 
#  DJINNI_FOUND       - djinni was found
#  DJINNI_INCLUDE_DIR - Include directory for djinni
#  DJINNI_LIBRARY     - djinni support library
#
#
#   This module accepts the following variables::
#
#  DJINNI_ROOT        - Preferred installation prefix
# 

include(FindPackageHandleStandardArgs)

# check if djinni variables are already set
if(NOT DJINNI_INCLUDE_DIR OR NOT DJINNI_LIBRARY)

    # set include paths that need to be searched for header files
    set(INCLUDE_PATHS ${DJINNI_ROOT}/include /usr/include /usr/local/include)
    # set library paths that need to be searched for library files
    set(LIBRARY_PATHS ${DJINNI_ROOT}/lib /usr/lib /usr/local/lib)

    # search for djinni/djinni_common.hpp
    find_path(DJINNI_INCLUDE_DIR NAMES djinni/djinni_common.hpp PATHS ${INCLUDE_PATHS})

    # search for djinni_support_lib and libdjinni_support_lib
    find_library(DJINNI_LIBRARY NAMES djinni_support_lib libdjinni_support_lib PATHS ${LIBRARY_PATHS})

    # check if the library was found
    if(DJINNI_INCLUDE_DIR AND DJINNI_LIBRARY)

        # set include and library variables for djinni
        set(DJINNI_INCLUDE_DIR ${DJINNI_INCLUDE_DIR} CACHE STRING "The include paths needed for djinni.")
        set(DJINNI_LIBRARY ${DJINNI_LIBRARY} CACHE STRING "The libraries needed by djinni.")

        # don't show these variables in cmake gui
        mark_as_advanced(DJINNI_INCLUDE_DIR DJINNI_LIBRARY)

    endif(DJINNI_INCLUDE_DIR AND DJINNI_LIBRARY)
endif(NOT DJINNI_INCLUDE_DIR OR NOT DJINNI_LIBRARY)

# handle the QUIETLY and REQUIRED arguments and set DJINNI_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(Djinni DEFAULT_MSG DJINNI_LIBRARY DJINNI_INCLUDE_DIR)
