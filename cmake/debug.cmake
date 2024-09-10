set(ELF "${CMAKE_PROJECT_NAME}.elf")


# OpenOCD options
string(SUBSTRING ${STM_BOARD} 7 2 OPENOCD_BOARD)
set (OPENOCD_BOARD "st_nucleo_${OPENOCD_BOARD}")
set(OPENOCD_FLAGS 
  --file ${PROJECT_SOURCE_DIR}/.openocd.cfg
  --file board/${OPENOCD_BOARD}.cfg
  --debug=1
)


# Flash the chip
add_custom_target(flash
  COMMAND openocd ${OPENOCD_FLAGS}
  -c \"program ${ELF} verify reset exit\"
  DEPENDS ${CMAKE_PROJECT_NAME}
)


# Debug
add_custom_target(openocd
  COMMAND openocd ${OPENOCD_FLAGS} 
  `printenv OPENOCD_ARGS`
  -c \"program ${ELF} reset\"
  DEPENDS ${CMAKE_PROJECT_NAME}
)
add_custom_target(gdb
	COMMAND ${TOOLCHAIN_PREFIX}gdb 
    -q
    --init-eval-command='target extended-remote :3333'
    --init-eval-command='set remotetimeout 120'
    --init-eval-command='monitor arm semihosting enable'
    --command=${PROJECT_SOURCE_DIR}/gdbinit
    ${ELF}
)
add_custom_target(debug
  COMMAND ../scripts/debug.sh
)


# Analyze ELF file
add_custom_target(elfread COMMAND readelf -l ${ELF})
add_custom_target(elfsize COMMAND ${CMAKE_SIZE} -G ${ELF})
add_custom_target(analyze DEPENDS elfread elfsize)
