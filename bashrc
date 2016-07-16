initMyDir () {
	if [ ! -d "${1}" ]; then
		echo "${1} missing, so I'm adding it"
		mkdir -p "${1}"
		echo "${2}" > "${1}/.info"
	fi
}

initMyDir "${HOME}/p" "Playground area for messing around"
initMyDir "${HOME}/s" "General webapps dir"
initMyDir "${HOME}/go" "Golang directory"
initMyDir "${HOME}/v" "A place to store common docker volumes"

# load in extra files
test -f ~/.bash_aliases && source ~/.bash_aliases
test -f ~/.bash_exports && source ~/.bash_exports
test -f ~/.bash_functions && source ~/.bash_functions
test -f ~/.bash_completion && source ~/.bash_completion
test -f ~/.bash_completion && source ~/.bash_completion
test -f /etc/bash_completion && source /etc/bash_completion
test -f /usr/local/git/contrib/completion/git-completion.bash && source /usr/local/git/contrib/completion/git-completion.bash
test -f /usr/local/git/contrib/completion/git-prompt.sh && source /usr/local/git/contrib/completion/git-prompt.sh
test -f /usr/local/bin/virtualenvwrapper.sh && source /usr/local/bin/virtualenvwrapper.sh

# mysql (osx)
if [ -d /usr/local/mysql/bin ]; then
	export PATH=/usr/local/mysql/bin:$PATH
fi

# local ip
LOCALIP=$(ipconfig getifaddr en0)

# golang
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin

# golang appengine sdk
if [ -d ~/go_appengine ]; then
	export PATH=~/go_appengine:$PATH
fi

export TERM=xterm-256color

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# OSX
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# PS1
export PS1="\T"'$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    # @4 - Clean repository - nothing to commit
    echo "\[\033[0;32m\]"$(__git_ps1 " (%s)"); \
  else \
    # @5 - Changes to working tree
    echo "\[\033[0;91m\]"$(__git_ps1 " {%s}"); \
  fi) \[\033[1;33m\]\w\[\033[0m\]\n\$ "; \
else \
  # @2 - Prompt when not in GIT repo
  echo " \[\033[1;33m\]\w\[\033[0m\]\n\$ "; \
fi)'

if [ "$PS1" ]; then # if running interactively, then run till 'fi' at EOF:

OS=$(uname)     # for resolving pesky os differing switches

export BLOCKSIZE=K              # set blocksize size
export BROWSER='chrome'            # set default browser
export CDDIR="$HOME"                # for use with the function 'cd' and the alias 'cdd'
export EDITOR='vi'              # use default text editor
export GREP_OPTIONS='-D skip --binary-files=without-match --ignore-case'      # most commonly used grep options
export HISTCONTROL=ignoreboth:erasedups     # for 'ignoreboth': ignore duplicates and /^\s/
export HISTIGNORE="&:ls:ll:la:l.:pwd:cd:exit:clear"
export HISTSIZE=10000               # increase or decrease the size of the history to '10,000'
export HISTTIMEFORMAT='%H:%M > '
export HISTTIMEFORMAT='%Y-%m-%d_%H:%M:%S_%a  '  # makes history display in YYYY-MM-DD_HH:MM:SS_3CharWeekdaySpaceSpace format
export HOSTFILE=$HOME/.hosts            # put list of remote hosts in ~/.hosts ...
export LC_COLLATE="en_CA.utf8"        # change sorting methods [a-Z] instead of [A-Z]
export LESSCHARSET='latin1'
export LESS='-i -N -w  -z-4 -g -e -M -X -F -R -P%t?f%f \'
export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-' # use this if lesspipe.sh exists
export PAGER='less -e'
export TERM='xterm'
export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export TMOUT=0                # auto logout after n seconds of inactivity
export VIDEO_FORMAT=NTSC            # for use with creating compatible DVDs ('dvdauthor -x dvdauthor.xml' will fail if this not here)
export VISUAL='vi'
set -b                      # causes output from background processes to be output right away, not on wait for next primary prompt
set bell-style visible            # I hate noise
set completion-ignore-case on         # complete things that have been typed in the wrong case
set -o notify                   # notify when jobs running in background terminate
shopt -s cdable_vars                # set the bash option so that no '$' is required (disallow write access to terminal)
shopt -s cdspell                # this will correct minor spelling errors in a cd command
shopt -s checkhash
shopt -s checkwinsize               # update windows size on command
shopt -s cmdhist                    # save multi-line commands in history as single line
shopt -s extglob                # necessary for bash completion (programmable completion)
shopt -s histappend histreedit histverify
shopt -s mailwarn               # keep an eye on the mail file (access time)
shopt -s nocaseglob                 # pathname expansion will be treated as case-insensitive (auto-corrects the case)
shopt -s no_empty_cmd_completion        # no empty completion (bash>=2.04 only)
shopt -s sourcepath
stty start undef
stty stop undef
ulimit -S -c 0                      # (core file size) don't want any coredumps

# completion
COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
complete -cf sudo

fi  # end interactive check﻿
