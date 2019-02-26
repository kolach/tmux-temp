# tmux-temp

Enables displaying k8s cluster name in Tmux status-right and status-left. Configurable icon display.

![](./screenshots/screenshot.png)

## Installation

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'kolach/tmux-temp'

Hit `prefix + I` to fetch the plugin and source it.

If format strings are added to `status-right`, they should now be visible.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/kolach/tmux-temp ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/temp.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf

If format strings are added to `status-right`, they should now be visible.

## Usage

Add any of the supported format strings (see below) to the existing `status-right` tmux option.
Example:

    # in .tmux.conf
    set -g status-right 'temp: #{temp_cpu} | %a %h-%d %H:%M '

### Supported Options

- `#{temp_units}` - Temperature units. Valid options: "C" or "F" (default "C")

