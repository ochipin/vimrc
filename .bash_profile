# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc -a "$0" = "bash" ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

# Export PATH
export GOPATH=$HOME/.go/vendor
export RBENV_ROOT=~/.rbenv
export PATH=$HOME/.go/bin:$GOPATH/bin:$RBENV_ROOT/bin:$PATH

# eval "$(rbenv init -)"
