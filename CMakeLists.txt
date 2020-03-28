cmake_minimum_required(VERSION 3.0)
project(simbullet_example)

# find package Foo (example library)
find_package(simbullet REQUIRED)

include_directories(${SIMBULLET_INCLUDE_DIRS})

# build type
set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build." FORCE)
set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
             "Debug"
             "Release"
             "MinSizeRel"
             "RelWithDebInfo"
)

# add binary
add_executable(car_circle_gui CarCircleGui.cpp)

# add library
target_link_libraries(car_circle_gui ${SIMBULLET_LIBRARIES})