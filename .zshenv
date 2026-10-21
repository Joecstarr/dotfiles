if [[ ! -o login ]]; then
  # Environment variables
  . "/nix/store/4h2llxdkykhy8j5cbl216skjzx00qnwm-hm-session-vars.sh/etc/profile.d/hm-session-vars.sh"

  # Only source this once
  if [[ -z "${__HM_ZSH_SESS_VARS_SOURCED-}" ]]; then
    export __HM_ZSH_SESS_VARS_SOURCED=1
    export LD_LIBRARY_PATH="/nix/store/604gsr59rj7dzd0nrhp143rpvf7gyiaz-gcc-15.3.0-lib/lib:$LD_LIBRARY_PATH"
  fi
fi
