#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# shellcheck source=scripts/helpers.sh
source "$CURRENT_DIR/scripts/helpers.sh"

temp_interpolation=(
  "\\#{temp_cpu}"
)

temp_commands=(
  "#($CURRENT_DIR/scripts/temp_cpu.sh)"
)

do_interpolation() {
  local all_interpolated="$1"
  for ((i=0; i<${#temp_commands[@]}; i++)); do
    all_interpolated=${all_interpolated/${temp_interpolation[$i]}/${temp_commands[$i]}}
  done
  echo "$all_interpolated"
}

update_tmux_option() {
  local option=$1

  local option_value
  option_value=$(get_tmux_option "$option")

  local new_option_value
  new_option_value=$(do_interpolation "$option_value")

  set_tmux_option "$option" "$new_option_value"
}

main() {
  update_tmux_option "status-right"
  update_tmux_option "status-left"
}
main
