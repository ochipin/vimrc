# .bash_profile

# Get the aliases and functions
if [[ -f ~/.bashrc && "$0" =~ [-]*bash ]]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

# Export PATH
export PATH=$HOME/.go/bin:$HOME/go/bin:$PATH
