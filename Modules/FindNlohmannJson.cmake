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

# FindNlohmannJson
# -----------
#
#  Try to find the nlohmann json library - https://github.com/nlohmann/json
#
#
#  This module defines the following variables::
# 
#  NLOHMANNJSON_FOUND         - nlohmann json was found
#  NLOHMANN_JSON_INCLUDE_DIR  - Include directories for nlohmann json
#  NLOHMANN_JSON_INCLUDE_FILE - Include file for nlohmann json
#
#
#   This module accepts the following variables::
#
#  NLOHMANN_JSON_ROOT        - Preferred installation prefix
# 

include(FindPackageHandleStandardArgs)

# check if include variable is already set
if(NOT NLOHMANN_JSON_INCLUDE_DIR)

    # set include paths that need to be searched for header files
    set(INCLUDE_PATHS ${NLOHMANN_JSON_ROOT}/include /usr/include /usr/local/include)

    # search for nlohmann/json.hpp
    find_path(NLOHMANN_JSON_INCLUDE_DIR NAMES nlohmann/json.hpp PATHS ${INCLUDE_PATHS})
    
    # check if the library was found
    if(NLOHMANN_JSON_INCLUDE_DIR)

        # set include variable for nlohmann json
        set(NLOHMANN_JSON_INCLUDE_DIR ${NLOHMANN_JSON_INCLUDE_DIR} CACHE STRING "The include paths needed for nlohmann json.")
        set(NLOHMANN_JSON_INCLUDE_FILE ${NLOHMANN_JSON_INCLUDE_DIR}/nlohmann/json.hpp CACHE STRING "The include file needed for nlohmann json.")

        # don't show these variables in cmake gui
        mark_as_advanced(NLOHMANN_JSON_INCLUDE_DIR NLOHMANN_JSON_INCLUDE_FILE)

    endif(NLOHMANN_JSON_INCLUDE_DIR)
endif(NOT NLOHMANN_JSON_INCLUDE_DIR)

# handle the QUIETLY and REQUIRED arguments and set NLOHMANN_JSON_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(NlohmannJson DEFAULT_MSG
                                  NLOHMANN_JSON_INCLUDE_FILE NLOHMANN_JSON_INCLUDE_DIR)
