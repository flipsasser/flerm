# ~/.hashrc
# vim:set ft=sh sw=2 sts=2:

rails_root() {
  (
  dir=${1:-$(pwd)}
  i=0
  while [ "/" != "$dir" -a "$i" -ne 16 ]; do
    if [ -f "$dir/config/environment.rb" ]; then
      echo "$dir"
      return 0
    fi
    dir="$(dirname "$dir")"
    i=$(expr $i + 1)
  done
  return 1
  )
}

script_rails() {
  if [ -f "`rails_root`/script/rails" ]; then
    "`rails_root`/script/rails" "$@"
  else
    local name
    name="$1"
    shift
    "`rails_root`/script/$name" "$@"
  fi
}

# git_prompt_info accepts 0 or 1 arguments (i.e., format string)
# returns text to add to bash PS1 prompt (includes branch name)
git_prompt_info () {
  local g="$(git rev-parse --git-dir 2>/dev/null)"
  if [ -n "$g" ]; then
    local r
    local b
    local d
    local s
    # Rebasing
    if [ -d "$g/rebase-apply" ] ; then
      if test -f "$g/rebase-apply/rebasing" ; then
        r="|REBASE"
      fi
      b="$(git symbolic-ref HEAD 2>/dev/null)"
    # Interactive rebase
    elif [ -f "$g/rebase-merge/interactive" ] ; then
      r="|REBASE-i"
      b="$(cat "$g/rebase-merge/head-name")"
    # Merging
    elif [ -f "$g/MERGE_HEAD" ] ; then
      r="|MERGING"
      b="$(git symbolic-ref HEAD 2>/dev/null)"
    else
      if [ -f "$g/BISECT_LOG" ] ; then
        r="|BISECTING"
      fi
      if ! b="$(git symbolic-ref HEAD 2>/dev/null)" ; then
        if ! b="$(git describe --exact-match HEAD 2>/dev/null)" ; then
          b="$(cut -c1-7 "$g/HEAD")..."
        fi
      fi
    fi

    # Dirty Branch
    local newfile='?? '
    if [ -n "$ZSH_VERSION" ]; then
      newfile='\?\? '
    fi
    d=''
    s=$(git status --porcelain 2> /dev/null)
    [[ $s =~ "$newfile" ]] && d+='+'
    [[ $s =~ "M " ]] && d+='*'
    [[ $s =~ "D " ]] && d+='-'

    printf "${1-"(%s) "}" "${b##refs/heads/}$r$d"
  fi
}

gco () {
  if [[ $1 == '.' ]]; then
    git add -A
    git commit -m "CHECKING OUT CURRENT DIRECTORY" -q
    git reset HEAD^ -q
    git checkout .
  else
    git checkout "$@"
  fi
}

alias gap='git add -p'
alias gb='git branch'
alias gc='git commit -v'
alias gca='git commit -a -v'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdh='git diff HEAD'
alias gl='git pull'
alias glod='git log --oneline --decorate'
alias gln="git ln | perl -ple 's/\*/sprintf(\"%2s\", \$n++)/e' | less"
alias gp='git push'
alias gpr='git pull --rebase'
alias gst='git status'
alias gr='git rebase'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias reset-authors='git commit --amend --reset-author -C HEAD'
alias vi='vim'

# Store 10,000 history entries
export HISTSIZE=10000
# Don't store duplicates
export HISTCONTROL=erasedups
# Append to history file
shopt -s histappend

VISUAL=vim
EDITOR="$VISUAL"
LESS="FRX"
RI="--format ansi -T"
PSQL_EDITOR='vim -c"setf sql"'
CLICOLOR=1
LSCOLORS=gxgxcxdxbxegedabagacad

export VISUAL EDITOR LESS RI PSQL_EDITOR CLICOLOR LSCOLORS

bind 'set bind-tty-special-chars off'
bind '"\ep": history-search-backward'
bind '"\en": history-search-forward'
bind '"\C-w": backward-kill-word'

export HISTIGNORE="%*"
bind '"\C-q": "%-\n"'

[ -z "$PS1" ] || stty -ixon

[ -z "$PS1" ] || export PS1="\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;36m\]\W\[\033[00m\]\$(git_prompt_info '(%s)')$ "

# Load RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Ensure RVM's fuckage with our $PATH doesn't hurt poor little Homebrew
PATH=~/.bin:/usr/local/bin:$PATH

# Add `is` command
alias "die"="killall -HUP -9"
alias "is"="ps ax -o pid,comm |grep "
alias "wat"="lsof |grep "

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
