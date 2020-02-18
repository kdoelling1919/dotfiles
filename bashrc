PATH="${PATH}:/usr/local/bin"

if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

# functions for prompt customization
gb() {
  branch=$( git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/' )
  if [ -z $branch ]; then
    color="\033[00m"
  else
    if ( git status | grep -qe "Changes not staged" -e "Untracked files" );then
      color="\033[33m"
    else
      color="\033[32m"
    fi
  fi
  echo -e $color$branch
}

shortwd() {
    num_dirs=3
    pwd_symbol="..."
    newPWD="${PWD/#$HOME/~}"
    if [ $(echo -n $newPWD | awk -F '/' '{print NF}') -gt $num_dirs ]; then
        newPWD=$(echo -n $newPWD | awk -F '/' '{print ".../" $(NF-1) "/" \
          $(NF)}')
    fi
    echo -n $newPWD
}

export PS1="\u:\[\033[34m\]\$(shortwd)\$(gb) $ \[\033[00m\]"
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
