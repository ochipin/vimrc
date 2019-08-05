# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

# Export PATH
export GOPATH=$HOME/.go/vendor
export PATH=$HOME/.go/bin:$GOPATH/bin:$PATH

# PS1 added git branch name output
gitbranch() {
    local branch=`git rev-parse --abbrev-ref HEAD 2>/dev/null`
    case $branch in
        "") ;;
        master) echo -e " \e[1;31m$branch\e[m" ;;
        devel*) echo -e " \e[1;33m$branch\e[m" ;;
        HEAD) ;;
        *) echo -e " \e[1;32m$branch\e[m" ;;
    esac
}

now() {
    date +%H:%M:%S
}

# export PS1='[\u@\h:\[\033[01;34m\]\W\[\033[00m\]$(gitbranch)]\[\033[01;37m\]\$\[\033[00m\] '
export PS1='[\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\] ($(now)$(gitbranch))]\$ '
# Added Proxy Server
# export https_proxy=http://proxy.com:8080
# export http_proxy=$https_proxy
