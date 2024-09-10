# STM32  naming scheme
#
# Example: 
# STM32F303RET6
# 0    12345678
#
# 0. STM_FAMILY
# 1. STM_PRODUCTTYPE
# 2. STM_CORE (Series Number)
# 3. STM_SUBLINE
# 4. STM_LINE
# 5. STM_PINS
# 6. STM_FLASHSIZE
# 7. STM_PACKAGE
# 8. STM_TEMPERATURE
# 
# 0. STM_FAMILY
# | 8  | 8-bit
# | 32 | 32-bit
#
# 1. STM_PRODUCTTYPE
# | A  | automotive
# | F  | mainstream, fundation
# | H  | high performance
# | L  | ultra-low power
# | S  | standard
# | T  | touch sensing
# | W  | wireless
# | xP | fastroom
#
# 2. STM_CORE (Series Number)
# | 0 | Corext-M0
# | 1 | Corext-M3
# | 2 | Corext-M3
# | 3 | Corext-M4
# | 4 | Corext-M4
# | 7 | Corext-M7
#
# 3. STM_SUBLINE
# | 3 | small die
# | 5 | medium die
# | 7 | big die
# | 9 | high integration
#
# 4. STM_LINE
# | 0 | value
# | 1 | access
# | 2 | usb
# | 5 | otg
# | 6 | lcd/tft+otg
# | 7 | ethernet
# | 8 | regulator off
# | 9 | lcd tft
#
# 5. STM_PINS
# | D | 14 pins
# | Y | 20 pins (STM8)
# | F | 20 pins (STM32)
# | E | 24,25 pins
# | G | 28 pins
# | K | 32 pins
# | T | 36 pins
# | H | 40 pins
# | S | 44 pins
# | C | 48,49 pins
# | U | 63 pins
# | R | 64,66 pins
# | J | 72 pins
# | M | 80 pins
# | O | 90 pins
# | V | 100 pins
# | Q | 132 pins
# | Z | 144 pins
# | A | 169 pins
# | I | 176,201 (175 + 25) pins
# | B | 208 pins
# | N | 216 pins
# | X | 256 pins
#
# 6. STM_FLASHSIZE
# | 4 | 16 KB
# | 6 | 32 KB
# | 8 | 64 KB
# | B | 128 KB
# | C | 256 KB
# | D | 384 KB
# | E | 512 KB
# | F | 768 KB
# | G | 1024 KB
# | H | 1536 KB
# | I | 2048 KB
# | J | 4096 KB
# 
# 7. STM_PACKAGE
# | B | DIP (plastic)
# | C | DIP (ceramic)
# | Q | QFP (plastic)
# | G | QFP (ceramic)
# | T | LQFP
# | U | UFQFPN
# | V | VFQFPN
# | H | LFBGA/TFBGA
# | I | UFBGA pitch .5 inch
# | J | UFBGA pitch .8 inch
# | K | UFBGA pitch .65 inch
# | M | SO (plastic)
# | P | TSOOP
# | Y | WLCSP
# 
# 8. STM_TEMPERATURE
# | 6/A | -40 ~ 85 °C
# | 7/B | -40 ~ 105 °C
# | 3/C | -40 ~ 125 °C
# | D   | -40 ~ 150 °C
#
#
# references: 
# - https://stm32world.com/wiki/STM32
# - https://www.st.com/en/microcontrollers-microprocessors/stm32-32-bit-arm-cortex-mcus.html
# - https://www.digikey.com/en/maker/tutorials/2020/understanding-stm32-naming-conventions


function (stm_chipclass chipname)
  set (onevalueargs OUTPUT)
  cmake_parse_arguments (STM_CHIPCLASS "" "${onevalueargs}" "" "${ARGN}")
  string (SUBSTRING ${chipname} 0 9 chipline)
  string (SUBSTRING ${chipname} 10 1 flashsize)
  set (out "${chipline}x${flashsize}")
  string (TOLOWER ${out} ${STM_CHIPCLASS_OUTPUT})
  return(PROPAGATE ${STM_CHIPCLASS_OUTPUT})
endfunction ()


function (stm_chipclassupper chipname)
  set (onevalueargs OUTPUT)
  cmake_parse_arguments (STM_CHIPCLASS "" "${onevalueargs}" "" "${ARGN}")
  string (SUBSTRING ${chipname} 0 9 chipline)
  string (SUBSTRING ${chipname} 10 1 flashsize)
  string (TOUPPER ${chipline} chipline)
  string (TOUPPER ${flashsize} flashsize)
  set (${STM_CHIPCLASS_OUTPUT} "${chipline}x${flashsize}")
  return(PROPAGATE ${STM_CHIPCLASS_OUTPUT})
endfunction ()


function (stm_chipfamily chipname)
  set (onevalueargs OUTPUT)
  cmake_parse_arguments (STM_CHIPFAMILY "" "${onevalueargs}" "" "${ARGN}")
  string (SUBSTRING ${chipname} 0 5 chipfamily)
  string (TOLOWER ${chipfamily} ${STM_CHIPFAMILY_OUTPUT})
  return(PROPAGATE ${STM_CHIPFAMILY_OUTPUT})
endfunction ()


function (stm_chiptype chipname)
  set (onevalueargs OUTPUT)
  cmake_parse_arguments (STM_CHIPTYPE "" "${onevalueargs}" "" "${ARGN}")
  string (SUBSTRING ${chipname} 5 1 type)
  string (TOLOWER ${type} ${STM_CHIPTYPE_OUTPUT})
  return(PROPAGATE ${STM_CHIPTYPE_OUTPUT})
endfunction ()


function (stm_chipcore chipname)
  set (onevalueargs OUTPUT)
  cmake_parse_arguments (STM_CHIPCORE "" "${onevalueargs}" "" "${ARGN}")
  string (SUBSTRING ${chipname} 6 1 ${STM_CHIPCORE_OUTPUT})
  return(PROPAGATE ${STM_CHIPCORE_OUTPUT})
endfunction ()


function (stm_chipcorename chipname)
  set (onevalueargs OUTPUT)
  cmake_parse_arguments (STM_CHIPCORE "" "${onevalueargs}" "" "${ARGN}")
  string (SUBSTRING ${chipname} 6 1 core)
  if (${core} STREQUAL "0")
	  set (${STM_CHIPCORE_OUTPUT} "Cortex-M0")
  elseif (${core} STREQUAL "1" OR ${core} STREQUAL "2")
	  set (${STM_CHIPCORE_OUTPUT} "Cortex-M3")
  elseif (${core} STREQUAL "3" OR ${core} STREQUAL "3")
	  set (${STM_CHIPCORE_OUTPUT} "Cortex-M4")
  elseif (${core} STREQUAL "7")
	  set (${STM_CHIPCORE_OUTPUT} "Cortex-M7")
  endif ()
  # string (TOLOWER ${chipfamily} ${STM_CHIPCORE_OUTPUT})
  return(PROPAGATE ${STM_CHIPCORE_OUTPUT})
endfunction ()
