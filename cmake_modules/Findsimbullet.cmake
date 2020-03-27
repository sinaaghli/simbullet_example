# - try to find simbullet library
#
# Example-simbullet.cmake
#
# This example is for a pretty simple library but that is still fairly
# common in its complexity.
#
# Cache Variables: (probably not for direct use in your scripts)
#  simbullet_INCLUDE_DIR
#  simbullet_LIBRARY
#
# Non-cache variables you might use in your CMakeLists.txt:
#  simbullet_FOUND
#  simbullet_INCLUDE_DIRS
#  simbullet_LIBRARIES
#  simbullet_RUNTIME_LIBRARIES - aka the dll for installing
#  simbullet_RUNTIME_LIBRARY_DIRS
#
# Requires these CMake modules:
#  FindPackageHandleStandardArgs (known included with CMake >=2.6.2)
#
# Original Author:
# 2009-2010 Ryan Pavlik <rpavlik@iastate.edu> <abiryan@ryand.net>
# http://academic.cleardefinition.com
# Iowa State University HCI Graduate Program/VRAC
#
# Copyright Iowa State University 2009-2010.
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE_1_0.txt or copy at
# http://www.boost.org/LICENSE_1_0.txt)

set(simbullet_ROOT_DIR
	"${simbullet_ROOT_DIR}"
	CACHE
	PATH
	"Directory to search")

if(CMAKE_SIZEOF_VOID_P MATCHES "8")
	set(_LIBSUFFIXES /lib64 /lib)
else()
	set(_LIBSUFFIXES /lib)
endif()

find_library(simbullet_LIBRARY
	NAMES
	simbullet
	PATHS
	"${simbullet_ROOT_DIR}"
	PATH_SUFFIXES
	"${_LIBSUFFIXES}")

# Might want to look close to the library first for the includes.
get_filename_component(_libdir "${simbullet_LIBRARY}" PATH)

find_path(simbullet_INCLUDE_DIR
	NAMES
	simbullet.h
	HINTS
	"${_libdir}" # the library I based this on was sometimes bundled right next to its include
	"${_libdir}/.."
	PATHS
	"${simbullet_ROOT_DIR}"
	PATH_SUFFIXES
	include/)

# There's a DLL to distribute on Windows - find where it is.
set(_deps_check)
if(WIN32)
	find_file(simbullet_RUNTIME_LIBRARY
		NAMES
		simbullet.dll
		HINTS
		"${_libdir}")
	set(simbullet_RUNTIME_LIBRARIES
		"${simbullet_RUNTIME_LIBRARY}")
	get_filename_component(simbullet_RUNTIME_LIBRARY_DIRS
		"${simbullet_RUNTIME_LIBRARY}"
		PATH)
	list(APPEND _deps_check simbullet_RUNTIME_LIBRARY)
else()
	get_filename_component(simbullet_RUNTIME_LIBRARY_DIRS
		"${simbullet_LIBRARY}"
		PATH)
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(simbullet
	DEFAULT_MSG
	simbullet_LIBRARY
	simbullet_INCLUDE_DIR
	${_deps_check})

if(simbullet_FOUND)
	set(simbullet_LIBRARIES "${simbullet_LIBRARY}")
	set(simbullet_INCLUDE_DIRS "${simbullet_INCLUDE_DIR}")
	mark_as_advanced(simbullet_ROOT_DIR)
endif()

mark_as_advanced(simbullet_INCLUDE_DIR
	simbullet_LIBRARY
	simbullet_RUNTIME_LIBRARY)