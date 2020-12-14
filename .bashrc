# .bashrc

# Get the aliases and functions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# rm/cp/mv コマンドは、毎度確認するようにする
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ls='/bin/ls --color=auto -v'
alias ll='ls -l'
alias grep='/bin/grep --color=auto'

# 現在最新のタグを表示する
gittag() {
    local tagname=`git describe --tags --first-parent --abbrev=0 2>/dev/null`
    if [[ $tagname != "" ]] ; then echo ":$tagname"; fi
}

# ブランチ名を取得する
# 事前に、"git" をインストールしておくこと!
# ex) dnf install git / apt-get install git
__gitbranch() {
    local branch=`git rev-parse --abbrev-ref HEAD 2>/dev/null`
    case $branch in
        "") ;;
        HEAD)
            branch=`git rev-parse --short HEAD 2>/dev/null`
            if [ "$branch" = "" ]; then
                branch=master
            fi
            ;;
    esac
    echo $branch
}

# 右側にGitプロンプトを表示する
__gitprompt() {
    if [[ "`git rev-parse --is-inside-work-tree 2>/dev/null`" = "true" ]]; then
        local branch=`__gitbranch`
        local toplevel=`git rev-parse --show-toplevel`
        local dirname=`basename $toplevel`
        local unstage
        local nocommit
        local untrack
        local RPROMPT1="[$dirname][$branch]"
        # ステージングされておらず、変更されたファイルがある場合(*)
        git diff --no-ext-diff --quiet
        if [[ ! $? = 0 ]]; then
            unstage='\e[1;31m*'
            RPROMPT1="*$RPROMPT1"
        fi
        # コミットされていない場合(+)
        git diff --no-ext-diff --cached --quiet
        if [[ ! $? = 0 ]]; then
            nocommit='\e[0;33m+'
            RPROMPT1="+$RPROMPT1"
        fi
        # 未追跡ファイルがある場合(%)
        git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' >/dev/null 2>&1
        if [ $? = 0 ]; then
            untrack='\e[0;34m%%'
            RPROMPT1="%$RPROMPT1"
        fi
        # 右側にGitプロンプトを表示する
        local RPROMPT="$untrack$nocommit$unstage[$dirname][$branch]\e[m"
        local width=$(($COLUMNS - ${#RPROMPT1} - 2))
        printf "%${width}s\e[1;32m$RPROMPT\\r" ''
    fi
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
        EC="EC:\\[\\033[01;32m\\]$RES\\[\\033[00m\\]]\\[\\033[01;32m\\]\\$\\[\\033[00m\\]"
    else
        EC="EC:\\[\\033[01;31m\\]$RES\\[\\033[00m\\]]\\[\\033[01;31m\\]\\$\\[\\033[00m\\]"
    fi

    # [時間][ユーザID@ホスト名:ディレクトリ名 (ブランチ名) コマンド実行成否] を表示する
    PS1="\\[\\033[33m\\][\\t]\\[\\033[00m\\][$__prompt_user:$DIR $EC "

    # 右プロンプトにブランチ名やステージング、プロジェクトディレクトリ情報を表示する
    __gitprompt
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

# umask を設定
umask 022

# LS_COLORSの変更
if [ -f ~/.dircolors ]; then
    export LS_COLORS=`cat ~/.dircolors`
fi
