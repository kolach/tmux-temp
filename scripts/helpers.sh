get_tmux_option() {
  local option="$1"
  local default_value="$2"
  local option_value
  option_value="$(tmux show-option -gqv "$option")"
  if [ -z "$option_value" ]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

set_tmux_option() {
  local option=$1
  local value=$2
  tmux set-option -gq "$option" "$value"
}

command_exists() {
  local command="$1"
  command -v "$command" &> /dev/null
}

# formula fahrenheit=(9/5)*celsius+32
celsius_to_fahrenheit() {
  echo "scale=2;((9/5) * $1) + $1" | bc
}
