#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# shellcheck source=helpers.sh
source "$CURRENT_DIR/helpers.sh"

print_cpu_temp() {
  if command_exists "sensors"; then
    local u=$1
    local t=$(sensors | sed '/^[^Package]/d' | sed '/^\s*$/d' | tail -n 1 | awk '{a=$4} END {printf("%f", a)}')
    if [ "$u" = "F" ]; then
      t=$(celsius_to_fahrenheit "$t")
    fi
    printf "%3.0fº%s" "$t" "$u"
  else
    echo "no sensors found"
  fi
}

main() {
  local units=$(get_tmux_option "@temp_units" "C")
  print_cpu_temp "$units"
}
main
