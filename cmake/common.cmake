if(CMAKE_C_STANDARD LESS 11)
    message(ERROR "Generated code requires C11 or higher")
endif()


# Build type and debug symbols
set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "debug" "release")
if (NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "debug" CACHE STRING "Include debug symbols" FORCE)
endif ()


# Menu config
add_custom_target(menu COMMAND ccmake ${PROJECT_BINARY_DIR} )
add_custom_target(fresh COMMAND cmake ${PROJECT_SOURCE_DIR} --fresh)
