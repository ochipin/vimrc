# .bashrc

# User specific aliases and functions
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# ブランチ名を取得する
gitbranch() {
    local branch=`git rev-parse --abbrev-ref HEAD 2>/dev/null`
    case $branch in
        # コミットされたことがない場合は何も表示しない
        "" | HEAD) ;;
        # master ブランチの場合は、赤色
        master) echo -e " \e[1;31m$branch\e[m" ;;
        # devel ブランチの場合は、黄色
        devel*) echo -e " \e[1;33m$branch\e[m" ;;
        # master, devel 以外のブランチは緑
        *)      echo -e " \e[1;32m$branch\e[m" ;;
    esac
}

# 現在時刻を取得する
nowtime() {
    date +"%H:%M:%S"
}

__prompt_user="\\u@\\h"
# root の場合は、usernameとhostnameを赤色に設定する
if [ "`id -u`" = "0" ]; then
    __prompt_user="\\[\\033[01;31m\\]\\u@\\h\\[\\033[00m\\]"
fi

PROMPT_COMMAND=__prompt_command
__prompt_command() {
    local curr_exit="$?"

    if [ $curr_exit != 0 ]; then
        # コマンド実行エラーの場合
        PS1="[$__prompt_user:\\[\\033[01;34m\\]\\W\\[\\033[00m\\] ($(nowtime)$(gitbranch)) \\[\\033[01;31m\\]EC:$curr_exit\\[\\033[00m\\]]\\[\\033[01;31m\\]\\$\\[\\033[00m\\] "
    else
        # コマンド実行成功の場合
        PS1="[$__prompt_user:\\[\\033[01;34m\\]\\W\\[\\033[00m\\] ($(nowtime)$(gitbranch)) EC:$curr_exit]\\[\\033[01;32m\\]\\$\\[\\033[00m\\] "
    fi

    # コマンド実行直後.bash_historyに書き込む場合は、下記コメントを外す
    # history -a
    # history -c
    # history -r
}

# 実行日時(YYYY-MM-DD HH:MI:SS)を.bash_historyへ保存する
export HISTTIMEFORMAT='%F %T '

# なるべく多くのコマンド履歴を保存する
export HISTSIZE=100000
export HISTFILESIZE=100000

# .bash_historyに保存しないコマンドを設定する
# export HISTIGNORE='history:pwd:ls:ls *:ll:w:top:df *'

# 重複・空白の場合は.bash_historyへ保存しない
export HISTCONTROL=ignoreboth
# プロキシの設定が必要な場合、下記のコメントを外し、プロキシ設定を追加する
# export http_proxy=http://xx.x.xx.xx:8888
# export https_proxy=http://xx.x.xx.xx:8888

# DIR_COLORSの変更
eval $('dircolors')
