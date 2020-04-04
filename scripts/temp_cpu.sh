#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# shellcheck source=helpers.sh
source "$CURRENT_DIR/helpers.sh"

print_cpu_temp() {
  local temp
  local units=$1

  # try with very common lm-sensors package
  if command_exists "sensors"; then
    temp=$(sensors | sed '/^[^Package]/d' | sed '/^\s*$/d' | tail -n 1 | awk '{a=$4} END {printf("%f", a)}')

  # try if this is Raspberry Pi
  elif command_exists "vcgencmd"; then
    temp=$(vcgencmd measure_temp | tr -d -c 0-9.)

  else
    echo "no sensors found"
  fi

  if [ "$units" = "F" ]; then
    temp=$(celsius_to_fahrenheit "$temp")
  fi
  printf "%3.0fº%s" "$temp" "$units"
}

main() {
  local units
  units=$(get_tmux_option "@temp_units" "C")
  print_cpu_temp "$units"
}
main
