__wezterm_set_user_var() {
  if hash base64 2>/dev/null; then
    if [[ -z "${TMUX}" ]]; then
      printf "\033]1337;SetUserVar=%s=%s\007" "$1" $(echo -n "$2" | base64)
    else
      # <https://github.com/tmux/tmux/wiki/FAQ#what-is-the-passthrough-escape-sequence-and-how-do-i-use-it>
      # Note that you ALSO need to add "set -g allow-passthrough on" to your tmux.conf
      printf "\033Ptmux;\033\033]1337;SetUserVar=%s=%s\007\033\\" "$1" $(echo -n "$2" | base64)
    fi
  fi
}

__wezterm_set_user_var "foo" "bar"
