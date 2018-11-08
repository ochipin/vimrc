" vim8は次の手順で導入可能
" 1. yum install lua-devel perl-ExtUtils-Embed ruby-devel ncurses-devel
" 2. git clone https://github.com/vim/vim
" 3. cd vim && make && make install

" シンタックス有効化
syntax on

" 独自カラースキームを読み込む
" vim8からは、vimrcにhighlight設定をしても適用されないので、
" $VIMRUNTIME/syntax/syncolor.vim を ~/.vim/colors/syncolor.vim へコピーする
" コピーした、syncolor.vimへ独自のhighlight設定をすること
let g:colors_name = "syncolor"
" hi Comment ctermfg=2
" hi Statement ctermfg=3
" hi Boolean term=bold ctermfg=130 gui=bold guifg=Brown

" vim 256色対応
set t_Co=256

" ファイルタイプ自動検出無効化
filetype off
filetype plugin indent off

" 互換性モード廃止
if &compatible
    set nocompatible
endif

" vim plugin 有効化 :BundleInstall で、プラグインをインストール可能
" $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" git clone できない場合は、次のコマンドを実行する必要がある
" yum install nss curl libcurl
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" git commit 時以外、git plugin 有効化
if expand("%t") != ".git/COMMIT_EDITMSG"
    " $ git clone https://github.com/airblade/vim-gitgutter.git ~/.vim/bundle/vim-gitgutter
    Plugin 'airblade/vim-gitgutter'
endif
" $ git clone https://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive
Plugin 'tpope/vim-fugitive'

" カーソル、バックスペースキーを通常エディタと同じ操作にする
set backspace=start,eol,indent
set whichwrap=b,s,[,],,~

" 2バイト文字も正しく表示できるように設定
set ambiwidth=double

" ステータスラインの設定
set laststatus=2
set statusline=%<%F\ %h%m%r%{fugitive#statusline()}%=%-14.(all=%L\ %l,%c%V%)\ \[ENC=%{&fileencoding}]%P
" set statusline=%F%r%h%a=all:%L,%P:%l,%c

" Go言語の場合はハードタブを有効、タブ幅を4とする
" $ git clone https://github.com/fatih/vim-go.git ~/.vim/bundle/vim-go
if expand("%t") =~ ".*\.go"
    let g:go_fmt_command = "goimports"
    let g:go_gocode_unimported_packages = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_structs = 1
    let g:go_highlight_function_calls = 1

    set noexpandtab
    set tabstop=4
    set shiftwidth=4
    " Go シンタックス有効化
    Plugin 'fatih/vim-go'
    Plugin 'nsf/gocode', {'rtp': 'vim/'}
" Go言語以外はソフトタブを有効とし、タブ幅を4とする
else
    set expandtab
    set tabstop=4
    set shiftwidth=4
endif

" 適当な*.goファイルを開き、:GoInstallBinariesを実行することで、Go関連のツールをインストール
call vundle#end()
filetype plugin indent on

" 行番号/検索時のハイライトを表示する
set number
set hlsearch
" 行番号/検索時のハイライトの表示・非表示を切り替えるショートカット
nnoremap <silent> <C-n> :set number!<CR>
nnoremap <silent> <C-i> :set hlsearch!<CR>
" Ctrl + l キーで git diff 表示
nnoremap <silent> <C-l> :GitGutterEnable<CR>

" 以前開いたことがあるファイルの、カーソル位置へ移動する
augroup vimrcEx
    au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal g'\"" | endif
augroup END
" 保存時に、git diff表示を有効にする
autocmd BufWritePost * :GitGutterEnable

" 次の設定を.bashrc/.bash_profileどちらかに記載することでgit環境は整う
" gitbranch() {
"     local branch=`git rev-parse --abbrev-ref HEAD 2>/dev/null`
"     case $branch in
"         "") ;;
"         master) echo -e " (\e[1;31m$branch\e[m)" ;;
"         devel*) echo -e " (\e[1;33m$branch\e[m)" ;;
"         *) echo -e " (\e[1;32m$branch\e[m)" ;;
"     esac
" }
" export PS1='[\u@\h:\[\033[01;34m\]\W\[\033[00m\]$(gitbranch)]\$ '
