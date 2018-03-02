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

# FindSOCI
# -----------
#
#  Try to find the SOCI library - https://github.com/SOCI/soci
#
#
#  This module defines the following variables::
# 
#  SOCI_FOUND             - SOCI was found
#  SOCI_INCLUDE_DIR       - Include directories for SOCI
#  SOCI_LIBRARIES         - Libraries of SOCI
#
#  SOCI_MYSQL_FOUND       - SOCI MySQL Module was found
#  SOCI_SQLITE_FOUND      - SOCI SQLite Module was found
#  SOCI_OBDC_FOUND        - SOCI OBDC Module was found
#  SOCI_POSTGRESQL_FOUND  - SOCI PostgreSQL Module was found
#
#   This module accepts the following variables::
#
#  SOCI_ROOT              - Preferred installation prefix
# 

include(FindPackageHandleStandardArgs)

# check if soci variables are already set
if(NOT SOCI_INCLUDE_DIR OR NOT SOCI_LIBRARIES)

    # set include paths that need to be searched for header files
    set(INCLUDE_PATHS ${SOCI_ROOT}/include /usr/include /usr/local/include)
    # set library paths that need to be searched for library files
    set(LIBRARY_PATHS ${SOCI_ROOT}/lib /usr/lib /usr/local/lib)

    # search for soci/version.h
    find_path(SOCI_INCLUDE_DIR NAMES soci/version.h PATHS ${INCLUDE_PATHS})

    # search for soci core library
    find_library(SOCI_CORE_LIBRARY NAMES soci_core libsoci_core PATHS ${LIBRARY_PATHS})
    if(NOT ${SOCI_CORE_LIBRARY} STREQUAL "SOCI_CORE_LIBRARY-NOTFOUND")
        set(SOCI_LIBRARIES ${SOCI_CORE_LIBRARY})
        message(STATUS "Found 'SOCI Core' at: ${SOCI_CORE_LIBRARY}")
    endif()

    # search for soci empty library
    find_library(SOCI_EMPTY_LIBRARY NAMES soci_empty libsoci_empty PATHS ${LIBRARY_PATHS})
    if(NOT ${SOCI_EMPTY_LIBRARY} STREQUAL "SOCI_EMPTY_LIBRARY-NOTFOUND")
        set(SOCI_LIBRARIES ${SOCI_LIBRARIES} ${SOCI_EMPTY_LIBRARY})
        message(STATUS "Found 'SOCI Empty' at: ${SOCI_EMPTY_LIBRARY}")
    endif()
    
    # search for SOCI MySQL
    find_library(SOCI_MYSQL_LIBRARY NAMES soci_mysql libsoci_mysql PATHS ${LIBRARY_PATHS})
    if(NOT ${SOCI_MYSQL_LIBRARY} STREQUAL "SOCI_MYSQL_LIBRARY-NOTFOUND")
        set(SOCI_LIBRARIES ${SOCI_LIBRARIES} ${SOCI_MYSQL_LIBRARY})
        set(SOCI_MYSQL_FOUND ON)
        message(STATUS "Found 'SOCI MySQL' Module at: ${SOCI_MYSQL_LIBRARY}")
    else()
        set(SOCI_MYSQL_FOUND OFF)
    endif()
    mark_as_advanced(SOCI_MYSQL_FOUND)

    # search for SOCI SQLite
    find_library(SOCI_SQLITE_LIBRARY NAMES soci_sqlite3 libsoci_sqlite3 PATHS ${LIBRARY_PATHS})
    if(NOT ${SOCI_SQLITE_LIBRARY} STREQUAL "SOCI_SQLITE_LIBRARY-NOTFOUND")
        set(SOCI_LIBRARIES ${SOCI_LIBRARIES} ${SOCI_SQLITE_LIBRARY})
        set(SOCI_SQLITE_FOUND ON)
        message(STATUS "Found 'SOCI SQLite' Module at: ${SOCI_SQLITE_LIBRARY}")
    else()
        set(SOCI_SQLITE_FOUND OFF)
    endif()
    mark_as_advanced(SOCI_SQLITE_FOUND)

    # search for SOCI OBDC
    find_library(SOCI_ODBC_LIBRARY NAMES soci_odbc libsoci_odbc PATHS ${LIBRARY_PATHS})
    if(NOT ${SOCI_ODBC_LIBRARY} STREQUAL "SOCI_ODBC_LIBRARY-NOTFOUND")
        set(SOCI_LIBRARIES ${SOCI_LIBRARIES} ${SOCI_ODBC_LIBRARY})
        set(SOCI_OBDC_FOUND ON)
        message(STATUS "Found 'SOCI OBDC' Module at: ${SOCI_ODBC_LIBRARY}")
    else()
        set(SOCI_OBDC_FOUND OFF)
    endif()
    mark_as_advanced(SOCI_OBDC_FOUND)

    # search for SOCI PostgreSQL
    find_library(SOCI_POSTGRESQL_LIBRARY NAMES soci_postgresql libsoci_postgresql PATHS ${LIBRARY_PATHS})
    if(NOT ${SOCI_POSTGRESQL_LIBRARY} STREQUAL "SOCI_POSTGRESQL_LIBRARY-NOTFOUND")
        set(SOCI_LIBRARIES ${SOCI_LIBRARIES} ${SOCI_POSTGRESQL_LIBRARY})
        set(SOCI_POSTGRESQL_FOUND ON)
        message(STATUS "Found 'SOCI PostgreSQL' Module at: ${SOCI_POSTGRESQL_LIBRARY}")
    else()
        set(SOCI_POSTGRESQL_FOUND OFF)
    endif()
    mark_as_advanced(SOCI_POSTGRESQL_FOUND)

    # check if required libraries are found
    if(NOT ${SOCI_CORE_LIBRARY} STREQUAL "SOCI_CORE_LIBRARY-NOTFOUND" AND NOT ${SOCI_EMPTY_LIBRARY} STREQUAL "SOCI_EMPTY_LIBRARY-NOTFOUND")
        set(SOCI_FOUND_REQUIRED ON)
    else()
        set(SOCI_FOUND_REQUIRED OFF)
    endif()
    mark_as_advanced(SOCI_FOUND_REQUIRED)
    
    # check if the library was found
    if(SOCI_INCLUDE_DIR AND SOCI_LIBRARIES AND SOCI_FOUND_REQUIRED)

        # set include and library variables for soci
        set(SOCI_INCLUDE_DIR ${SOCI_INCLUDE_DIR} CACHE STRING "The include paths needed for soci.")
        set(SOCI_LIBRARIES ${SOCI_LIBRARIES} CACHE STRING "The libraries for soci.")

        # don't show these variables in cmake gui
        mark_as_advanced(SOCI_INCLUDE_DIR SOCI_LIBRARIES)

    endif(SOCI_INCLUDE_DIR AND SOCI_LIBRARIES AND SOCI_FOUND_REQUIRED)
endif(NOT SOCI_INCLUDE_DIR OR NOT SOCI_LIBRARIES)

# handle the QUIETLY and REQUIRED arguments and set SOCI_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(SOCI DEFAULT_MSG
                                  SOCI_LIBRARIES SOCI_INCLUDE_DIR)
