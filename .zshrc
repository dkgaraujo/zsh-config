# Enable version control info (for git)
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats ' (branch: %b)'

# Enable prompt substitution
setopt prompt_subst

# Custom gradient prompt with optional aliasing
generate_username_with_gradient() {
  local raw_username="${USER}"
  local emoji=$'\U1F4BB'  # 💻
  local enable_alias=true # Toggle this to false if you want to disable aliasing

  local username_display
  if $enable_alias && [[ "$raw_username" == "douglasaraujo" ]]; then
    username_display=$'\U1F920'
    username_display+="@$emoji"
  else
    username_display="${raw_username}@$emoji"
  fi

  # Split into individual characters (including emoji)
  local -a chars
  IFS='' chars=(${(s::)username_display})
  local display_len=${#chars[@]}

  # Base half gradient (mirrored later)
  local -a gradient_half=(16 17 18 23 30 37 44 51)  # Feel free to customize
  local half_len=$((display_len / 2))
  local -a gradient=(${gradient_half[1,half_len]})

  # Build full symmetric gradient
  local -a full_gradient
  if (( display_len % 2 == 0 )); then
    full_gradient=(${gradient} ${(O)gradient})
  else
    full_gradient=(${gradient} ${gradient[-1]} ${(O)gradient})
  fi

  # Construct prompt with colorized background per character
  local output=""
  for ((i = 1; i <= display_len; i++)); do
    local color=${full_gradient[i]}
    output+="%{\e[48;5;${color}m\e[38;5;15m%}${chars[i]}"
  done

  output+="%{\e[0m%}"  # Reset
  echo "$output"
}

# Final prompt
PROMPT='$(generate_username_with_gradient) %F{yellow}%~%F{green}${vcs_info_msg_0_}%f%k %# '

