// Copyright 2024 Vahid Mardani
/*
 * This file is part of stm-boilerplate.
 *  stm-boilerplate is free software: you can redistribute it and/or modify it
 *  under the terms of the GNU General Public License as published by the Free
 *  Software Foundation, either version 3 of the License, or (at your option)
 *  any later version.
 *
 *  stm-boilerplate is distributed in the hope that it will be useful, but
 *  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 *  or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
 *  for more details.
 *
 *  You should have received a copy of the GNU General Public License along
 *  with stm-boilerplate. If not, see <https://www.gnu.org/licenses/>.
 *
 *  Author: Vahid Mardani <vahid.mardani@gmail.com>
 */
#include <stdio.h>
#include <stdint.h>

#include "config.h"


#if (CMAKE_BUILD_TYPE == debug)
extern void initialise_monitor_handles(void);
#elif (CMAKE_BUILD_TYPE == release)
#include "syscalls.c"
#endif


int
main(void) {
    /* Semihosting debug */
#if CMAKE_BUILD_TYPE == debug
    initialise_monitor_handles();
#endif

    int i = 2343;
    printf("Hello stm32f303!\n");
    printf("i = %d\n", i);

    /* Loop forever */
    for (;;) {
        printf("Hello stm32f303!\n");
    }
}
