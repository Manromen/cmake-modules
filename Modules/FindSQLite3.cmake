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

# FindSQLite3
# -----------
#
#  Try to find the SQLite3 library - https://sqlite.org
#
#
#  This module defines the following variables::
# 
#  SQLITE3_FOUND       - SQLite3 was found
#  SQLITE3_INCLUDE_DIR - Include directories for SQLite3
#  SQLITE3_LIBRARIES   - Libraries of SQLite3
#
#
#   This module accepts the following variables::
#
#  SQLITE3_ROOT        - Preferred installation prefix
# 

include(FindPackageHandleStandardArgs)

# check if sqlite3 variables are already set
if(NOT SQLITE3_INCLUDE_DIR OR NOT SQLITE3_LIBRARIES)

    # set include paths that need to be searched for header files
    set(INCLUDE_PATHS ${SQLITE3_ROOT}/include /usr/include /usr/local/include)
    # set library paths that need to be searched for library files
    set(LIBRARY_PATHS ${SQLITE3_ROOT}/lib /usr/lib /usr/local/lib)

    # search for sqlite3.h and sqlite3ext.h
    find_path(SQLITE3_INCLUDE_DIR NAMES sqlite3.h sqlite3ext.h PATHS ${INCLUDE_PATHS})
    # search for sqlite3 and libsqlite3
    find_library(SQLITE3_LIBRARIES NAMES sqlite3 libsqlite3 PATHS ${LIBRARY_PATHS})

    # check if the library was found
    if(SQLITE3_INCLUDE_DIR AND SQLITE3_LIBRARIES)

        # set include and library variables for sqlite3
        set(SQLITE3_INCLUDE_DIR ${SQLITE3_INCLUDE_DIR} CACHE STRING "The include paths needed for sqlite3.")
        set(SQLITE3_LIBRARIES ${SQLITE3_LIBRARIES} CACHE STRING "The libraries needed by sqlite3.")

        # don't show these variables in cmake gui
        mark_as_advanced(SQLITE3_INCLUDE_DIR SQLITE3_LIBRARIES)

    endif(SQLITE3_INCLUDE_DIR AND SQLITE3_LIBRARIES)
endif(NOT SQLITE3_INCLUDE_DIR OR NOT SQLITE3_LIBRARIES)

# handle the QUIETLY and REQUIRED arguments and set SQLITE3_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(SQLite3 DEFAULT_MSG
    SQLITE3_LIBRARIES SQLITE3_INCLUDE_DIR)
