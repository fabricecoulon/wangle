# - Try to find Glog
# Once done, this will define
#
# GLOG_FOUND - system has Glog
# GLOG_INCLUDE_DIRS - the Glog include directories
# GLOG_LIBRARIES - link these to use Glog
include(FindPackageHandleStandardArgs)

find_library(GLOG_LIBRARY glog
  PATHS ${GLOG_LIBRARYDIR})

find_path(GLOG_INCLUDE_DIR glog/logging.h
  PATHS ${GLOG_INCLUDEDIR})

find_package_handle_standard_args(glog DEFAULT_MSG
  GLOG_LIBRARY
  GLOG_INCLUDE_DIR)

mark_as_advanced(
  GLOG_LIBRARY
  GLOG_INCLUDE_DIR)

set(GLOG_LIBRARIES ${GLOG_LIBRARY})
set(GLOG_INCLUDE_DIRS ${GLOG_INCLUDE_DIR})

if (glog_FOUND)
  MESSAGE("Found glog from package config")
else()
  find_package(GLog MODULE)
endif()

if(glog_FOUND AND NOT TARGET glog::glog)
    add_library(glog::glog STATIC IMPORTED)
    set_target_properties(glog::glog PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${GLOG_INCLUDE_DIR}"
    )
endif()
