" シンタックス有効化
syntax on

" vim 256色対応
set t_Co=256

" 真偽値、コメント、キーワードの色をそれぞれ変更
hi Boolean term=bold ctermfg=130 gui=bold guifg=Brown
hi Comment ctermfg=2
hi Statement ctermfg=3

" ファイルタイプ自動検出無効化
filetype off

" 互換性モード廃止
if &compatible
    set nocompatible
endif

" vim plugin 有効化
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" カーソル、バックスペースキーを通常エディタと同じ操作にする
set backspace=start,eol,indent
set whichwrap=b,s,[,],,~

" 2バイト文字も正しく表示できるように設定
set ambiwidth=double

" ステータスラインの設定
set statusline=%F%r%h%a=all:%L,%P:%l,%c
set laststatus=2

" Go言語の場合はハードタブを有効、タブ幅を4とする
if expand("%t") =~ ".*\.go"
    set noexpandtab
    set tabstop=4
    set shiftwidth=4
    " Go シンタックス有効化
    Plugin 'fatih/vim-go'
" Go言語以外はソフトタブを有効とし、タブ幅を4とする
else
    set expandtab
    set tabstop=4
    set shiftwidth=4
endif

filetype plugin indent on

" 行番号を表示する
set number

" 行番号の表示・非表示を切り替える関数
function Setnumber()
    if &number
        setlocal nonumber
    else
        setlocal number
    endif
endfunction

" ショートカットキー、 Ctrl + N で行番号の表示・非表示を切り替える
nnoremap <silent> <C-n> :call Setnumber()<CR>

" 以前開いたカーソル位置へ移動する
augroup vimrcEx
    au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal g'\"" | endif
augroup END
