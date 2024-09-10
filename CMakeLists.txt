cmake_minimum_required(VERSION 3.28.3)
project(foo
  VERSION 0.1.0
  LANGUAGES ASM C
)


# Verbosity
set(CMAKE_RULE_MESSAGES OFF)
set(CMAKE_VERBOSE_MAKEFILE OFF)


include(cmake/common.cmake)
include(cmake/stm.cmake)
include(cmake/lint.cmake)
include(cmake/debug.cmake)


# config.h
configure_file(
  ${CMAKE_PROJECT_NAME}/config.h.in 
  ${CMAKE_PROJECT_NAME}/config.h @ONLY
)
include_directories(
  ${PROJECT_SOURCE_DIR} 
  ${PROJECT_BINARY_DIR}/${CMAKE_PROJECT_NAME}
)


# include directories
include_directories(
  ${PROJECT_SOURCE_DIR}/arm
  ${PROJECT_SOURCE_DIR}/${STM_CHIP_FAMILY}
  ${PROJECT_SOURCE_DIR}/${CMAKE_PROJECT_NAME}
)


# executable binary
add_executable(${CMAKE_PROJECT_NAME}
  ${PROJECT_SOURCE_DIR}/${STM_CHIP_FAMILY}/${STM_CHIP_CLASS}_startup.s
  ${PROJECT_SOURCE_DIR}/${STM_CHIP_FAMILY}/${STM_CHIP_SYSTEM}_system.c
  ${PROJECT_SOURCE_DIR}/${CMAKE_PROJECT_NAME}/sysmem.c
  ${PROJECT_SOURCE_DIR}/${CMAKE_PROJECT_NAME}/main.c
)
if (CMAKE_BUILD_TYPE STREQUAL "release")
  target_sources(${CMAKE_PROJECT_NAME}
    PRIVATE
      ${PROJECT_SOURCE_DIR}/${CMAKE_PROJECT_NAME}/syscalls.c
  )
endif ()


# suppress linker warning about rwx segemnts
target_link_options(${CMAKE_PROJECT_NAME}
    PRIVATE
    "LINKER:--no-warn-rwx-segments"
)


# show binary size after each build
add_custom_command(TARGET ${CMAKE_PROJECT_NAME} 
  POST_BUILD COMMAND ${CMAKE_SIZE} $<TARGET_FILE:${CMAKE_PROJECT_NAME}>
)


# make info
add_custom_target(info
  COMMAND echo -e "chip: ${STM_CHIP}"
  COMMAND echo -e "class: ${STM_CHIP_CLASS}"
  COMMAND echo -e "class upper: ${STM_CHIP_CLASS_UPPER}"
  COMMAND echo -e "system: ${STM_CHIP_SYSTEM}"
  COMMAND echo -e "family: ${STM_CHIP_FAMILY}"
  COMMAND echo -e "type: ${STM_CHIP_TYPE}"
  COMMAND echo -e "core: ${STM_CHIP_CORE}"
  COMMAND echo -e "core name: ${STM_CHIP_CORENAME}"
  COMMAND echo -e "ld: ${LINKER_SCRIPT}"
  COMMAND echo -e "ld: ${STM_CHIP_CORE}"
  COMMAND echo -e $<TARGET_FILE:${CMAKE_PROJECT_NAME}>
  COMMAND echo -e "${STM_CHIP_FAMILY}/${STM_CHIP_CLASS}_startup.s"
)
