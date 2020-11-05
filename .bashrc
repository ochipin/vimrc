# .bashrc

# User specific aliases and functions
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ls='/usr/bin/ls --color=auto'
alias ll='ls -l'

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# 現在最新のタグを表示する
gittag() {
    local tagname=`git describe --tags --first-parent --abbrev=0 2>/dev/null`
    if [[ $tagname != "" ]] ; then echo ":$tagname"; fi
}

# 未追跡ファイル・変更されたファイルを分かるようにする
gitchange() {
    git status | grep '^\(Changes\|Untracked\)' 2>&1 >/dev/null
    if [[ "$?" = 0 ]]; then echo '*'; fi
}

# ブランチ名を取得する
# 事前に、"git" をインストールしておくこと!
# ex) dnf install git / apt-get install git
gitbranch() {
    local branch=`git rev-parse --abbrev-ref HEAD 2>/dev/null`
    case $branch in
        # コミットされたことがない場合は何も表示しない
        "") ;;
        # HEAD の場合は、基本何もしないが直接コミットIDを指定されている場合は水色にする
        HEAD)
            branch=`git rev-parse --short HEAD 2>/dev/null`
            if [ ! $branch = "" ]; then
                echo -e "(\e[1;36m`gitchange`$branch`gittag`\e[m) "
            fi
            ;;
        # masterブランチの場合は赤色
        master) echo -e "(\e[1;31m`gitchange`$branch`gittag`\e[m) " ;;
        # develブランチの場合は黄色
        devel*) echo -e "(\e[1;33m`gitchange`$branch`gittag`\e[m) " ;;
        # 上記以外のブランチの場合は緑にする
        *)      echo -e "(\e[1;32m`gitchange`$branch`gittag`\e[m) " ;;
    esac
}

# プロンプトの設定
__prompt_user='\u@\h'
# root の場合は、usernameとhostnameを赤色に設定する
if [ "`id -u`" = "0" ]; then
    __prompt_user='\[\033[01;31m\]\u@\h\[\033[00m\]'
fi

# コマンド実行の成否をプロンプトに表示する
PROMPT_COMMAND=__prompt_command
__prompt_command() {
    local RES=$?

    # カレントディレクトリがシンボリックリンクか否かを判定する
    if [ -L ${PWD} ]; then
        DIR='\[\033[01;36m\]\W\[\033[00m\]'
    else
        DIR='\[\033[01;34m\]\W\[\033[00m\]'
    fi

    # コマンドの実行結果を判定する
    if [ "$RES" = "0" ]; then
        EC="EC:$RES]\\[\\033[01;32m\\]\\$\\[\\033[00m\\]"
    else
        EC="\\[\\033[01;31m\\]EC:$RES]\\$\\[\\033[00m\\]"
    fi

    # [時間][ユーザID@ホスト名:ディレクトリ名 (ブランチ名) コマンド実行成否] を表示する
    PS1="\\[\\033[01m\\][\\t]\\[\\033[00m\\][$__prompt_user:$DIR $(gitbranch)$EC "

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

# 言語設定
export LANG=ja_JP.UTF-8

# プロキシの設定が必要な場合、下記のコメントを外し、プロキシ設定を追加する
# export http_proxy=http://xx.x.xx.xx:8888
# export https_proxy=http://xx.x.xx.xx:8888
# export no_proxy=localhost,127.0.0.1

umask 022

# DIR_COLORSの変更
eval $('dircolors')
