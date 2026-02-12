# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc) for examples.

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# set history length; see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# Bash autocomplete 
bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*)
  ;;
esac


export EDITOR=vim;

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto -F'
  alias grep='grep --color=auto'
  alias fgrep='grep -F --color=auto'
  alias egrep='grep -E --color=auto'
fi

# some more ls aliases
alias l='ls' 
alias la='ls -AFh'
alias ll='ls -lFh'
alias ld='ls -d */'
alias l.='ls -A | grep -E '\''^\.'\''' 
alias py3='python3'
alias vf='vim -p $(fzf -m)' 
alias df='df -h'  
alias du='du -ach | sort -h'
alias free='free -mt' 
alias cd..='cd ..' 
alias cpu='cpuid -i | grep uarch | head -n 1' 
alias distro='cat /etc/lsb-release'
alias kernel='ls /usr/lib/modules' 
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0| grep -E "state|to\ full|percentage"'

if command -v eza 2>&1 >/dev/null
then
  alias ll='eza -lF'
  alias la='eza -AF' 
fi

if command -v ranger 2>&1 >/dev/null
then
  alias l='. ranger' 
elif command -v nnn  2>&1 >/dev/null
then
  alias l='nnn' 
fi

if command -v zoxide 2>&1 >/dev/null
then
  eval "$(zoxide init bash)"
  alias cd='z' # zoxide
fi


# Set up fzf key bindings and fuzzy completion
if command -v fzf 2>&1 >/dev/null
then
  #eval "$(fzf --bash)"

  # Don't source FZF shell integrations if version is older than 0.48 (Avoids `unknown option: --bash`)
  # Version comparison technique courtesy of Luciano Andress Martini:
  # https://unix.stackexchange.com/questions/285924/how-to-compare-a-programs-version-in-a-shell-script
  FZF_VERSION="$(fzf --version | cut -d' ' -f1)"
  if [[ -f ~/.fzf.bash && "$(printf '%s\n' 0.48 "$FZF_VERSION" | sort -V | head -n1)" = 0.48 ]]; then
    . ~/.fzf.bash
  fi

  alias ff='fzf -e' # fzf in exact mode by default
fi


# Fastfetch or Neofetch
if command -v fastfetch 2>&1 >/dev/null
then
  fastfetch
elif command -v neofetch 2>&1 >/dev/null
then
  neofetch
fi

# Weather
curl wttr.in/{Barcelona,Darmstadt,Leipzig,Oxford,Boston}?format=4 

# Log date and IP address into file 
printf "%-11s %-10s %9s - External IP: %s\n" $(date +'%Y.%m.%d, %A, %T ')  $(curl -4 ifconfig.me 2> /dev/null) >> ~/ext_IP.txt 
