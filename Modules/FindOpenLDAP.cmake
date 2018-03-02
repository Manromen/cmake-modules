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

# FindOpenLDAP
# -----------
#
#  Try to find the Open LDAP library - https://www.openldap.org
#
#
#  This module defines the following variables::
# 
#  OpenLDAP_FOUND        - LDAP was found
#  OpenLDAP_INCLUDE_DIR  - Include directories for LDAP
#  OpenLDAP_LIBRARIES    - Libraries of LDAP
#
#
#
#  This module accepts the following variables::
#
#  OpenLDAP_ROOT         - Preferred installation prefix
# 

include(FindPackageHandleStandardArgs)

# we store if all required libraries are found
set(OpenLDAPFound ON)

# check if open ldap variables are already set
if(NOT OpenLDAP_INCLUDE_DIR OR NOT OpenLDAP_LIBRARIES)

    set(OpenLDAPFound OFF)

    # set include paths that need to be searched for header files
    set(INCLUDE_PATHS ${LDAP_ROOT}/include /usr/include /usr/local/include)
    
    # set library paths that need to be searched for library files
    set(LIBRARY_PATHS ${LDAP_ROOT}/lib /usr/lib /usr/local/lib)

    # search for ldap.h
    find_path(OpenLDAP_INCLUDE_DIR NAMES ldap.h PATHS ${INCLUDE_PATHS})

    # search for ldap and libldap
    find_library(LDAP_LIBRARY NAMES ldap libldap PATHS ${LIBRARY_PATHS})
    find_library(LDAP_R_LIBRARY NAMES ldap_r libldap_r PATHS ${LIBRARY_PATHS})

    # lber is a dependency by OpenLDAP and normally ships with the OpenLDAP library.
    find_library(LBER_LIBRARY NAMES lber liblber PATHS ${LIBRARY_PATHS})

    # sasl2 is a dependency by OpenLDAP and needs to be explicitly linked on Apple platforms
    if (APPLE)
        find_library(SASL2_LIBRARY NAMES sasl2 libsasl2 PATHS ${LIBRARY_PATHS})
        if (LDAP_LIBRARY AND LDAP_R_LIBRARY AND LBER_LIBRARY AND SASL2_LIBRARY AND OpenLDAP_INCLUDE_DIR)
            set(OpenLDAPFound ON)
        endif()
    else(APPLE)
        if (LDAP_LIBRARY AND LDAP_R_LIBRARY AND LBER_LIBRARY AND OpenLDAP_INCLUDE_DIR)
            set(OpenLDAPFound ON)
        endif()
    endif(APPLE)

    # check if the library was found
    if(OpenLDAPFound)

        # set include and library variables
        set(OpenLDAP_INCLUDE_DIR ${OpenLDAP_INCLUDE_DIR} CACHE STRING "The include paths needed for ldap.")

        if (APPLE)
            set(OpenLDAP_LIBRARIES "${LDAP_LIBRARY} ${LDAP_R_LIBRARY} ${LBER_LIBRARY} ${SASL2_LIBRARY}" CACHE STRING "The libraries needed for openldap.")
        else (APPLE)
            set(OpenLDAP_LIBRARIES "${LDAP_LIBRARY} ${LDAP_R_LIBRARY} ${LBER_LIBRARY}" CACHE STRING "The libraries needed for openldap.")
        endif(APPLE)

        # don't show these variables in cmake gui
        mark_as_advanced(OpenLDAP_INCLUDE_DIR OpenLDAP_LIBRARIES)

    endif(OpenLDAPFound)
endif(NOT OpenLDAP_INCLUDE_DIR OR NOT OpenLDAP_LIBRARIES)

# handle the QUIETLY and REQUIRED arguments and set LDAP_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(OpenLDAP DEFAULT_MSG
                                  OpenLDAP_LIBRARIES OpenLDAP_INCLUDE_DIR OpenLDAPFound)
