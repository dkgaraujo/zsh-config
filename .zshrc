prompt_fire_setup () {
  local fire1='black'    # First color
  local fire2='cyan'    # Second color
  local fire3='black'    # Third color
  local userhost='white'  # User@host color
  local date='green'      # Date color
  local cwd='yellow'       # Current directory color

  local -a schars
  autoload -Uz prompt_special_chars
  prompt_special_chars

  local GRAD1="%{$schars[333]$schars[262]$schars[261]$schars[260]%}"
  local GRAD2="%{$schars[260]$schars[261]$schars[262]$schars[333]%}"
  local COLOR1="%B%F{$fire1}%K{$fire2}"
  local COLOR2="%B%F{$userhost}%K{$fire2}"
  local COLOR3="%b%F{$fire3}%K{$fire2}"
  local COLOR4="%b%F{$fire3}%K{black}"
  local COLOR5="%B%F{$cwd}%K{black}"
  local COLOR6="%B%F{$date}%K{black}"
  local GRAD0="%b%f%k"

  local emoji=$'\U1F4BB'
 

  # Set the PS1 prompt
  PS1="$COLOR1$GRAD1$COLOR2%n@$(printf $emoji)$COLOR3$GRAD2$COLOR4$GRAD1$COLOR6$(date +'%Y-%m-%d %H:%M:%S') $GRAD0$COLOR5$(pwd | sed "s|$HOME|~|")$GRAD0 > "

  prompt_opts=(cr subst percent)
}

# Call the setup function
prompt_fire_setup


export PATH='/Users/douglasaraujo/.duckdb/cli/latest':$PATH
