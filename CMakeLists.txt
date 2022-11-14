cmake_minimum_required(VERSION 3.23.2)

project(CMakeNinjaTestProject)

option(CMAKE_NINJA_FORCE_RESPONSE_FILE "" ON)

# This function can be used to create a library where all C++ files are
# guaranteed to end up in the final executable. This skips the default
# behaviour (on most architectures) of dropping any object files from static
# libraries (.a files) that aren't directly referenced.
#
# Mostly used for static initialization of plugin-type features.
function(add_whole_library target_name)
    add_library(${target_name} ${ARGN})
    target_link_options(
        ${target_name}
        BEFORE
        PUBLIC
        "SHELL:LINKER:--whole-archive $<TARGET_FILE:${target_name}> LINKER:--no-whole-archive"
    )
endfunction()

execute_process(
                COMMAND rm -rf ${CMAKE_CURRENT_BINARY_DIR}/generated
                COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/create_sublibs.sh
                WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

add_executable(ex ex.cpp)

add_subdirectory(${CMAKE_CURRENT_BINARY_DIR}/generated)


