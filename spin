#!/usr/bin/env bash

"$@" &
pid=$!

spinner() {
  local spin='|/-\\'
  local i=0
  while kill -0 "$pid" 2>/dev/null; do
    printf "\r[%c] Working..." "${spin:i++%${#spin}:1}"
    sleep 0.1
  done
}

spinner
wait $pid
status=$?

# Final result message
if [ $status -eq 0 ]; then
  printf "\r[✓] Done           \n"
else
  printf "\r[✗] Failed         \n"
fi

exit $status
