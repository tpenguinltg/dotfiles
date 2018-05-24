#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# current date in milliseconds
curms() {
  date +%s%3N
}

CURMS=$(curms)

prettyms() {
  # Adapted from https://unix.stackexchange.com/a/27014
  # T is in milliseconds
  local T=$1
  local D=$((T/1000/60/60/24))
  local H=$((T/1000/60/60%24))
  local M=$((T/1000/60%60))
  local S=$((T/1000%60))
  local MS=$((T%1000))
  (( D > 0 )) && printf '%dd' $D
  (( H > 0 )) && printf '%02dh' $H
  (( M > 0 )) && printf '%02dm' $M
  printf '%02d.%03ds\n' $S $MS
}

# source other files
for f in \
  ~/.alias \
  /usr/share/git/completion/git-prompt.sh \
  ~/.bashrc.d/*.bash
do
  test -s "$f" && . "$f" || true
done

export HISTCONTROL=ignorespace

# Use gVim for $VISUAL if running in an X session
if [[ -v DISPLAY ]]; then
  export VISUAL=${VISUAL:-'/usr/bin/gvim --nofork'}
else
  export VISUAL=${VISUAL:-'/usr/bin/vim'}
fi

# define formatting
readonly COLOR_RED='\[\033[0;31m\]'
readonly COLOR_RED_BOLD='\[\033[1;31m\]'
readonly COLOR_GREEN='\[\033[0;32m\]'
readonly COLOR_GREEN_BOLD='\[\033[1;32m\]'
readonly COLOR_BLUE='\[\033[0;34m\]'
readonly COLOR_BLUE_BOLD='\[\033[1;34m\]'
readonly COLOR_CYAN='\[\033[0;36m\]'
readonly COLOR_CYAN_BOLD='\[\033[1;36m\]'
readonly COLOR_PURPLE='\[\033[0;35m\]'
readonly COLOR_PURPLE_BOLD='\[\033[1;35m\]'
readonly COLOR_YELLOW='\[\033[0;33m\]'
readonly COLOR_YELLOW_BOLD='\[\033[1;33m\]'
readonly FORMAT_RESET='\[\033[m\]'

__set_ps1() {
  local LAST_EXIT=$?
  local LASTMS=$CURMS
  local DIRS=$(dirs -v | tail -n 1 | awk '{ print $1 }')
  CURMS=$(curms)
  PS1="${COLOR_GREEN}\n[\D{%FT%T%z}|\l/\u@${COLOR_PURPLE}\h${COLOR_GREEN}:${COLOR_CYAN}\w${gitprompt}${COLOR_GREEN}>!\!] \${SHLVL}#\#$( ((DIRS)) && printf " ${COLOR_CYAN}\\\\${DIRS}")\$( ((\j)) && printf ' ${COLOR_PURPLE}&\j' )${COLOR_RED}$( ((LAST_EXIT)) && printf " ?${LAST_EXIT}")${COLOR_BLUE} +$(prettyms $((CURMS-LASTMS)))${COLOR_GREEN}\n\$${FORMAT_RESET} "
}

if command -v __git_ps1 >/dev/null; then
  GIT_PS1_SHOWDIRTYSTATE=auto
  GIT_PS1_SHOWSTASHSTATE=auto
  GIT_PS1_SHOWUNTRACKEDFILES=auto
  GIT_PS1_SHOWUPSTREAM=auto
  gitprompt='$(__git_ps1 "'"${COLOR_YELLOW}"' (%s)")'
fi

# set prompts if not in dumb terminal
if [[ $TERM != "dumb" ]]; then
  PROMPT_COMMAND="__set_ps1;$PROMPT_COMMAND"
  PS2="${COLOR_GREEN}\a> ${FORMAT_RESET}"
  PS4="${COLOR_BLUE}[\$(printf '%3d' \$LINENO)] + ${FORMAT_RESET}"
fi
