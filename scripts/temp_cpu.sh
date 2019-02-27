#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# shellcheck source=helpers.sh
source "$CURRENT_DIR/helpers.sh"

print_cpu_temp() {
  if command_exists "sensors"; then
    local units=$1
    local temp
    temp=$(sensors | sed '/^[^Package]/d' | sed '/^\s*$/d' | tail -n 1 | awk '{a=$4} END {printf("%f", a)}')
    if [ "$units" = "F" ]; then
      temp=$(celsius_to_fahrenheit "$temp")
    fi
    printf "%3.0fº%s" "$temp" "$units"
  else
    echo "no sensors found"
  fi
}

main() {
  local units
  units=$(get_tmux_option "@temp_units" "C")
  print_cpu_temp "$units"
}
main
