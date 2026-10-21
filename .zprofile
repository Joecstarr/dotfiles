# Environment variables
. "/nix/store/4h2llxdkykhy8j5cbl216skjzx00qnwm-hm-session-vars.sh/etc/profile.d/hm-session-vars.sh"

# Only source this once
if [[ -z "${__HM_ZSH_SESS_VARS_SOURCED-}" ]]; then
  export __HM_ZSH_SESS_VARS_SOURCED=1
  export LD_LIBRARY_PATH="/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib:$LD_LIBRARY_PATH"
fi

export PATH="$PATH${PATH:+:}$HOME/go/bin"
setopt no_beep                                              # no beep
setopt rm_star_wait                                             # wait 10 seconds before running `rm *`
setopt hist_ignore_dups                                         # ignore history duplication
setopt hist_expire_dups_first                                   # remove oldest duplicate commands from the history first
setopt hist_ignore_space                                        # don't save commands beginning with spaces to history
setopt append_history                                           # append to the end of the history file
setopt inc_append_history                                       # always be saving history (not just when the shell exits)
setopt no_flowcontrol                                          # Disable ^S and ^Q (freeze & resume flowcontro)

