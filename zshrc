##############################################################
# Utility functions
##############################################################

function os() {
  if [[ $(uname) == *Linux* ]]; then
    echo "Linux"
  elif [[ $(uname) == *Darwin* ]]; then
    echo "OSX"
  else
    echo "Unknown"
  fi
}

##############################################################
# Enviroment variables
##############################################################

# Used throughout this script.
export OS=$(os)

export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export HISTCONTROL=ignoredups
export SAVEHIST=10000

export EDITOR=vim
export LSCOLORS=exFxcxdxAxexbxHxGxcxBx

# So that vim in terminal mode is beautiful with solarized colorscheme.
export TERM="screen-256color"

# Prefer locally installed binaries.
export PATH=/usr/local/bin:$PATH:~/bin

##############################################################
# tmux management
##############################################################
#source ~/.zsh/tmux.zsh

##############################################################
# Prompt
##############################################################
source ~/.zsh/prompt.zsh

##############################################################
# For mounting an encrypted usb stick.
##############################################################

source ~/.zsh/usb_mount.zsh

##############################################################
# History
##############################################################

# Appends every command to the history file once it is executed
setopt inc_append_history
# Reloads the history whenever you use it
setopt share_history
# remove newlines from history
setopt HIST_REDUCE_BLANKS

##############################################################
# Aliases
##############################################################

if [ "$OS" = "Linux" ]; then
  alias ls='ls -Fph --color=auto'
elif [ "$OS" = "OSX" ]; then
  which gdircolors &>/dev/null
  if [[ $? -eq 0 ]]; then
    eval `gdircolors ~/.dir_colors`
    alias ls='gls -Fph --color=auto'
  else
    echo "gdircolors not found in path. " \
      "Probably not installed? Try installing with homebrew:" \
      "brew install coreutils"
  fi
fi

alias vimrc='$EDITOR ~/.vimrc'
alias zshrc='$EDITOR ~/.zshrc && source ~/.zshrc'
alias i3config='$EDITOR ~/.i3/config && i3-msg reload'
alias tmux='tmux -2'
alias grep='grep --color=always'
tohex() { echo "obase=16; $1" | bc | tr '[:upper:]' '[:lower:]'; }
todec() { a=${1:u}; echo "ibase=16; ${a#0X}" | bc; }

##############################################################
# Autocompletion
##############################################################

fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit
compinit

##############################################################
# Work specific
##############################################################

if [ -e ~/workdotfiles/zshrc ]; then
  source ~/workdotfiles/zshrc
fi
