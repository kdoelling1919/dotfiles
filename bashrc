PATH="${PATH}:/usr/local/bin"

if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

# functions for prompt customization
gb() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
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

export PS1="\u:\[\033[36m\]\$(shortwd)\[\033[32m\]\$(gb) $ \[\033[00m\]"
