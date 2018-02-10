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

# FindMySQLClient
# -----------
#
#  Try to find the MySQL C Client library - https://dev.mysql.com/downloads/connector/c/
#
#
#  This module defines the following variables::
# 
#  MYSQLCLIENT_FOUND        - MySQL Client was found
#  MYSQLCLIENT_INCLUDE_DIR  - Include directories for MySQL Client
#  MYSQLCLIENT_LIBRARIES    - Libraries of MySQL Client
#
#
#  This module accepts the following variables::
#
#  MYSQLCLIENT_ROOT         - Preferred installation prefix
# 

include(FindPackageHandleStandardArgs)

# check if mysql client variables are already set
if(NOT MYSQLCLIENT_INCLUDE_DIR OR NOT MYSQLCLIENT_LIBRARIES)

    # set include paths that need to be searched for header files
    set(INCLUDE_PATHS ${MYSQLCLIENT_ROOT}/include /usr/include /usr/local/include)
    
    # set library paths that need to be searched for library files
    set(LIBRARY_PATHS ${MYSQLCLIENT_ROOT}/lib /usr/lib /usr/local/lib)

    # search for mysql/client_plugin.h
    find_path(MYSQLCLIENT_INCLUDE_DIR NAMES mysql/client_plugin.h PATHS ${INCLUDE_PATHS})
    # search for mysqlclient and libmysqlclient
    find_library(MYSQLCLIENT_LIBRARIES NAMES mysqlclient libmysqlclient PATHS ${LIBRARY_PATHS})

    # check if the library was found
    if(MYSQLCLIENT_INCLUDE_DIR AND MYSQLCLIENT_LIBRARIES)

        # set include and library variables
        set(MYSQLCLIENT_INCLUDE_DIR ${MYSQLCLIENT_INCLUDE_DIR} CACHE STRING "The include paths needed for mysql client.")
        set(MYSQLCLIENT_LIBRARIES ${MYSQLCLIENT_LIBRARIES} CACHE STRING "The libraries needed by mysql client.")

        # don't show these variables in cmake gui
        mark_as_advanced(MYSQLCLIENT_INCLUDE_DIR MYSQLCLIENT_LIBRARIES)

    endif(MYSQLCLIENT_INCLUDE_DIR AND MYSQLCLIENT_LIBRARIES)
endif(NOT MYSQLCLIENT_INCLUDE_DIR OR NOT MYSQLCLIENT_LIBRARIES)

# handle the QUIETLY and REQUIRED arguments and set MYSQL_CLIENT_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(MySQLClient DEFAULT_MSG
                                  MYSQLCLIENT_LIBRARIES MYSQLCLIENT_INCLUDE_DIR)
