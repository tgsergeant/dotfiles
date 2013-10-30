# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="af-magic"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git mercurial python django pip archlinux svn brew osx zsh-syntax-highlighting)

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

source $ZSH/oh-my-zsh.sh

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/core_perl

# NO BEEP
unsetopt beep

typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}

[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line

# HIGHLIGHT OF THE FILE, RIGHT HERE
ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=blue'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=blue'


# ALIASES
alias vps='ssh -i ~/.ssh/vps-things.pem -D 1080 tim@things.room342.net'
alias homesick="$HOME/.homeshick"
alias o='open'
alias l='ls'
alias v='vim'
alias slog='svn log | less'
alias sdiff='svn diff | less'


# JUMP
export MARKPATH=$HOME/.marks
function jump {
cd -P $MARKPATH/$1 2>/dev/null || echo "No such mark: $1"
}
function mark {
mkdir -p $MARKPATH; ln -s $(pwd) $MARKPATH/$1
}
function unmark {
rm -i $MARKPATH/$1
}
function marks {
ls -l $MARKPATH | sed 's/ / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

function _completemarks {
  reply=($(ls $MARKPATH))
}

compctl -K _completemarks jump
compctl -K _completemarks unmark

source $HOME/.zshpath #Store additions to path in a separate, unversioned file
