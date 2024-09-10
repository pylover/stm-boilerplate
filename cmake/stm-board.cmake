# supported stm boards
list (APPEND STM_BOARD_SUPPORTED 
  "nucleo-f303re" 
  "nucleo-f302r8"
)


set (STM_BOARD "nucleo-f303re" CACHE STRING "Development board")
set_property (CACHE STM_BOARD PROPERTY STRINGS ${STM_BOARD_SUPPORTED})
