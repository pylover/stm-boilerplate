#! /usr/bin/env bash
# A simple script which automates the make openocd & make gdb


list_descendants() {
  local children=$(ps -o pid= --ppid "$1")

  for pid in $children
  do
    list_descendants "$pid"
  done

  echo "$children"
}


# Catch interrupts
exitfn () {
    trap SIGINT
    if [ -n "${ocdpid}" ]; then
      echo
      echo "Killing pid ${ocdpid} and all children"
      children=$(list_descendants ${ocdpid})
      if [ -n "${children}" ]; then
        kill $(list_descendants ${ocdpid})
      fi
    fi
    exit 
}
trap "exitfn" INT


# Create a temp file for OpenOCD output
TMPFILE=/tmp/stm32-ocd.out
if [ -f ${TMPFILE} ]; then
  truncate -s0 ${TMPFILE}
else
  touch ${TMPFILE}
fi


# Run OpenOCD in background
make openocd OPENOCD_ARGS="--log_output ${TMPFILE}" &
ocdpid=$!


# Wait for flash the chip
tail -f ${TMPFILE} | grep -q '\*\* Resetting Target \*\*'


# Run debugger
make gdb


# Restore trap and exit!
exitfn
