#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# shellcheck source=helpers.sh
source "$CURRENT_DIR/helpers.sh"

print_gpu_temp() {
  local temp
  local units=$1

  # try if this is nvidia
  if command_exists "nvidia-smi"; then
    temp=$(nvidia-smi -q | awk '/CPU Current Temp/ {print $5}')
  # elif command_exists "ati"; then
  else
    echo "no GPU sensors found"
  fi

  if [ "$units" = "F" ]; then
    temp=$(celsius_to_fahrenheit "$temp")
  fi
  printf "%3.0fº%s" "$temp" "$units"
}

main() {
  local units
  units=$(get_tmux_option "@temp_units" "C")
  print_gpu_temp "$units"
}
main
