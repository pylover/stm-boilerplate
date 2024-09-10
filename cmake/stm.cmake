include(${PROJECT_SOURCE_DIR}/cmake/stm-naming.cmake)
include(${PROJECT_SOURCE_DIR}/cmake/stm-chip.cmake)
include(${PROJECT_SOURCE_DIR}/cmake/stm-board.cmake)


set (
  STM_CHIP_SYSTEM 
  ${STM_CHIP_FAMILY}${STM_CHIP_TYPE}${STM_CHIP_CORE}xx
)


# compiler flags

## target MCU flags
set (TARGET_FLAGS "-mcpu=${STM_CHIP_CORENAME}")
set (TARGET_FLAGS "${TARGET_FLAGS} -std=gnu11 ")


## chip specific
if (${STM_CHIP} STREQUAL "STM32F303RExx")
  set (TARGET_FLAGS "${TARGET_FLAGS} -mfpu=fpv4-sp-d16 -mfloat-abi=hard ")
elseif (${STM_CHIP} STREQUAL "STM32F303RExx")
  # TODO append c flags
endif ()


## C flags
set (CFLAGS "${CFLAGS} --specs=nano.specs")
set (CFLAGS "${CFLAGS} -mthumb ")
set (CFLAGS "${CFLAGS} -Wall ")
set (CFLAGS "${CFLAGS} -Wextra ")
set (CFLAGS "${CFLAGS} -Werror")
set (CFLAGS "${CFLAGS} -Wpedantic")
set (CFLAGS "${CFLAGS} -fdata-sections")
set (CFLAGS "${CFLAGS} -ffunction-sections")


if(CMAKE_BUILD_TYPE MATCHES debug)
  set(CFLAGS "${CFLAGS} -O0 -g3")
endif()
if(CMAKE_BUILD_TYPE MATCHES release)
  set(CFLAGS "${CFLAGS} -Os -g0")
endif()


## Cxx flags
set (CXXFLAGS "${CXXFLAGS} -fno-rtti")
set (CXXFLAGS "${CXXFLAGS} -fno-exceptions")
set (CXXFLAGS "${CXXFLAGS} -fno-threadsafe-statics")


## assembper flags
set (ASMFLAGS "${ASMFLAGS} -x assembler-with-cpp -MMD -MP")


## linker flags
set (
  LINKER_SCRIPT 
  "${CMAKE_SOURCE_DIR}/${STM_CHIP_FAMILY}/${STM_CHIP_LOWER}_flash.ld"
)
set (LDFLAGS "${LDFLAGS} -T${LINKER_SCRIPT}")
set (LDFLAGS "${LDFLAGS} --specs=nosys.specs")
set (LDFLAGS "${LDFLAGS} -lrdimon --specs=rdimon.specs")
set (LDFLAGS "${LDFLAGS} -Wl,-Map=${CMAKE_PROJECT_NAME}.map")
set (LDFLAGS "${LDFLAGS} -Wl,--gc-sections")
set (LDFLAGS "${LDFLAGS} -Wl,--start-group -lc -lm -Wl,--end-group")
set (LDFLAGS "${LDFLAGS} -Wl,--print-memory-usage")
# set (LDFLAGS "${LDFLAGS} -static") 


## all together
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CFLAGS} ${TARGET_FLAGS}")
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} ${ASMFLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} ${CXXFLAGS}")
set(CMAKE_C_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} ${LDFLAGS} ${TARGET_FLAGS}")
# 
# set(CMAKE_CXX_LINK_FLAGS "${CMAKE_C_LINK_FLAGS} -Wl,--start-group -lstdc++ -lsupc++ -Wl,--end-group")
