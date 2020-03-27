SET(PROJECT_NAME car_example)
PROJECT(${PROJECT_NAME})

CMAKE_MINIMUM_REQUIRED(VERSION 3.0.0)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake_modules/")

IF( NOT CMAKE_BUILD_TYPE )
   SET( CMAKE_BUILD_TYPE Release )
ENDIF()

FIND_PACKAGE( simbullet REQUIRED )

SET(LIBS "/usr/local/lib/libsimbullet.dylib")
# find_library(simbullet_LIB NAMES simbullet)
message("message-> ${simbullet_LIBRARIES}")
message("message-> ${simbullet_INCLUDE_DIRS}")

include_directories( ${simbullet_INCLUDE_DIRS} )
ADD_EXECUTABLE( ${PROJECT_NAME} main.cpp)
target_link_libraries( ${PROJECT_NAME} ${simbullet_LIBRARIES} )