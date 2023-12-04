# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

export NTFY_SERVER=''

export SPOTIPY_CLIENT_ID=''
export SPOTIPY_CLIENT_SECRET=''
export SPOTIPY_REDIRECT_URI='http://localhost:8080'

export OPENAI_API_KEY=''
export GPT4_MODEL='gpt-4-1106-preview'
#export GPT3_MODEL='gpt-3.5-turbo-instruct'
export GPT3_MODEL='gpt-3.5-turbo'


# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000000
HISTFILESIZE=20000000


PROMPT_DIRTRIM=1

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

alias open=xdg-open
alias pdf=evince
alias dog=bat

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi




# use all but 1 cores
JOBS=$((`nproc`-1))
#echo "You have $JOBS CPUs activated for HQ compilation hyperspeed"
#echo "box() → Dropbox"

export PS1='\[\e[1;32m\][\w]\$\[\e[0m\] '


alias pycat=pygmentize  # use bat (batcat) instead


# User specific aliases and functions
alias lint='python -m pylint -E --extension-pkg-whitelist=numpy'

alias lrt="ls -lrt"
alias lrta="ls -lrta"
alias la="ls -lah"

alias cgrep="grep -rn --include=*.c   --include=*.cc    --include=*.cpp \
                      --include=*.hpp --include=*.h     --include=*.hh \
                      --exclude=*.o   --exclude=*.cmake --exclude=*.html \
                      --exclude-dir=build"

alias pygrep="grep -rn --include=*.py --exclude-dir=build"
alias cmakegrep="grep -rn --include=CMakeLists.txt --include=*.cmake --exclude-dir=build"

alias m8='make -j8'
alias m8i='make -j8 install'

export PATH=~/.local/bin:~/.cargo/bin:$PATH


# PYTHONPATH
export PYTHONSTARTUP=~/.pythonrc

linefrom () {
    filename=$1
    lineno=$2
    head -n $lineno $filename | tail -n 1
}

createpwd_bash () {
    words=/usr/share/dict/words
    for i in {1..2}
    do
        WORD="'"
        while [[ "$WORD" =~ [^a-zA-Z0-9] ]]
        do
            WORD=`linefrom $words $RANDOM | awk '{if(length($0) >= 3 && length($0) < 9) printf "%s", tolower($0); else print "_"}'`
        done
        echo -n ${WORD^}
        echo -n "-"
    done
    NUM=`shuf -i 1000-9999 -n 1`
    echo $NUM
}

patience () {
    until timeout 3s $@
    do
    echo "stop trying to hit me and hit me"
    done
}

function calc() {
    python -c "from math import *;print(eval('$1'))"
}

function scicalc() {
    python -c "from math import *;import numpy as np;import pandas as pd;import scipy as sci;print(eval('$1'))"
}

function get_random() {
    #head -c 5000 /dev/urandom | tr -dc 'a-zA-Z0-9~!@#$%^&*_-' | fold -w 80 | head -n 1
    head -c 5000 /dev/urandom | tr -dc 'a-f0-9' | fold -w $1 | head -n 1
}


y () {
    echo "You're done ..."
}

function lastdiff() {
    git log $@ | tail -n 5
}




ENV_ROOT=/scratch/pdr081/envs
function activate() {
    if [ ${1} = "--list" ]
    then
        ls $ENV_ROOT
        return 0
    else
        ENV=${ENV_ROOT}/${1}
        if [[ -d $ENV ]]
        then
            echo "Activating env" $ENV
            source ${ENV}/bin/activate
        else
            echo "No such env \"${1}\", use --list"
            return 1
        fi
    fi
    return 0
}

function venv() {
    ENV=${ENV_ROOT}/$2

    if [ $1 = "2" ]
    then
        CMD="virtualenv $ENV"
    elif [ $1 = "3" ]
    then
        CMD="python3 -m venv $ENV"
    else
        printf "Usage: venv 2|3 name"
        return 1
    fi
    if [[ -d $ENV ]]
    then
        printf "Environment exists, delete first\n"
        return 1
    fi
    $CMD || (printf "\nError constructing env ${ENV}" && return 1)
    printf "Created ${2}, activating ...\n"
    activate ${2}
    printf "Activated ${2}, upgrading ...\n"
    pip install --upgrade pip
    pip install --upgrade setuptools wheel
    pip install --upgrade ipython numpy pandas matplotlib black ph
    printf "\nDone upgrading\n\n\n"
    python --version
    printf "\n"
    pip freeze
}


# Slugify name
function sify() {
    fname=$1
    slug=$(slugify $fname | rev | sed 's/-/./' | rev)
    mv "${fname}" ${slug}
}


function onmodify() {
    onmodify_fname=$1
    shift
    onmodify_exec=$1
    shift

    echo "listen to $onmodify_fname"
    echo "execute   $onmodify_exec"
    echo "args      $@"

    while [[ 1 ]]
    do
        if [[ $(inotifywait -q $onmodify_fname | grep MODIFY) ]]
        then
            echo
            $onmodify_exec $@
            the_exit_code=$?
            echo
            if [ "$the_exit_code" -eq "0" ]
            then
                echo "ok"
            else
                echo "fail ${the_exit_code}"
            fi
        fi
    done
}

function trgrep() {
    MAJ=$1
    MIN=$2
    MIC=$3

    git log -p | grep "${MAJ}\\.${MIN}\\.${MIC}" | cut -f 2- -d " " | trim | trim --internal | trim | trim -c "*" | trim | sort |uniq
}

function box() {
    cd /scratch/pdr081/Dropbox/Dropbox/
    pwd
}

function muboard() {
    firefox /Home/siv32/pdr081/git/muboard/muboard.html
}

function ntfy () {
    curl -d "$*" ntfy.sh/${NTFY_SERVER}
}

function c() {
    suffix=".tex"
    FNAME=${1%"$suffix"}
    latexmk -bibtex -pdf $FNAME
    makeindex $FNAME
    latexmk -bibtex -pdf $FNAME
    evince $FNAME.pdf &
}


function towav() {
    fin=$1
    fout=$2
    echo "Converting ${fin} to wav (${fout})"
    ffmpeg -i ${fin} -ac 1 -ar 16000 -f wav ${fout}
}


alias less=bat
#
export EDITOR=emacs
export VISUAL=emacs

alias whisper=/scratch/whisper.cpp/main
alias ec=emacsclient

function ntff () {
    curl -T $1  -H "Filename: $1" ntfy.sh/${NTFY_SERVER}
}
