cmake_minimum_required(VERSION 3.10)
project(lab-project-software)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

file(GLOB_RECURSE SOURCE_FILES src/*.c src/*.cpp)

add_executable(controller ${SOURCE_FILES})
