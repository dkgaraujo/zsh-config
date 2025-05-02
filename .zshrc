autoload -Uz vcs_info
precmd() { vcs_info }

# Enable git info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '(branch: %b)'

# Gradient behind username
generate_username_with_gradient() {
  local username="${USER}"
  local emoji=$'\U1F4BB'
  local -a chars
  IFS='' chars=(${(s::)username})

  local userlen=${#chars[@]}

  # Define a half gradient (will be mirrored)
  local -a gradient_half=(16 17 18 23 30 37 44)  # You can trim or expand this

  # Ensure we only use as many gradient steps as needed
  local half_len=$((userlen / 2))
  local -a gradient=(${gradient_half[1,half_len]})

  # Mirror the gradient around the center
  local -a full_gradient
  full_gradient=(${gradient} ${gradient[-1]} ${(O)gradient})  # Symmetric

  # Adjust in case of even-length usernames (remove double central color)
  if (( userlen % 2 == 0 )); then
    full_gradient=(${gradient} ${(O)gradient})  # no duplicate center
  fi

  local output=""
  for i in {1..$userlen}; do
    local color=${full_gradient[i-1]}
    output+="%{\e[48;5;${color}m\e[38;5;15m%}${chars[i]}"
  done

  # Append @💻 without affecting symmetry
  for c in "@" "$emoji"; do
    output+="%{\e[48;5;${full_gradient[-1]}m\e[38;5;15m%}${c}"
  done

  output+="%{\e[0m%}"  # Reset
  echo "$output"
}

setopt prompt_subst

PROMPT='$(generate_username_with_gradient) %F{yellow}%~ %F{green}${vcs_info_msg_0_}%f%k %# '

