" Gitプラグインの設定

" 保存時に、git diff表示を有効にする
if expand("%t") != ".git/COMMIT_EDITMSG"
    autocmd BufWritePost * :GitGutterEnable
endif

" Ctrl + l キーで git diff 表示
nnoremap <silent> <C-l> :GitGutterToggle<CR>

" 状況に応じてステータスラインの色を変更できるようにカスタマイズ
function! MyStatusLine()
    if mode() =~ 'i'
        " INSERT モード
        let c = 1
        let mode_name = 'INSERT'
    elseif mode() =~ 'n'
        " NORMAL モード
        let c = 2
        let mode_name = 'NORMAL'
    elseif mode() =~ 'R'
        " REPLACE モード
        let c = 3
        let mode_name = 'REPALCE'
    else
        " VISUAL モード
        let c = 4
        let mode_name = 'VISUAL'
    endif

    if expand('%:t') ==# ''
        " ファイル名が指定されていない場合
        let filename = '[NO NAME]'
    else
        " 1つ上のディレクトリ名/ファイル名とする
        let dirfiles = split(expand('%:p'), '/')
        if len(dirfiles) < 2
            let filename = dirfiles[0]
        else
            let filename = dirfiles[-2] . '/' . dirfiles[-1]
        endif
    endif

    let fugitive = ''
    " fugitive プラグイン導入済みの場合は statusline にセットする
    if exists('g:loaded_fugitive')
        let fugitive = FugitiveHead()
        " development
        if fugitive =~? '^devel\|^dev$'
            let fugitive = '%4*  '.fugitive.'  %*'
        " master
        elseif fugitive == 'master'
            let fugitive = '%3*  '.fugitive.'  %*'
        " feature
        elseif fugitive =~? '^feature'
            let fugitive = '%6*  '.fugitive.'  %*'
        " hotfix
        elseif fugitive =~? '^hotfix'
            let fugitive = '%1*  '.fugitive.'  %*'
        " ブランチなし
        elseif fugitive ==# ''
            let fugitive = ''
        else
            let fugitive = '  ['.fugitive.']  '
        endif
    endif

    if &readonly
        " RO の場合はファイル名を赤にする
        return '%'.c.'*  '.mode_name.'  %<%*%7*  %m%r'.filename.'  %*%h'.fugitive.'%=%6*  %Y  %*  %{&fileencoding} [%l/%L]'
    else
        " RW の場合はファイル名を白にする
        return '%'.c.'*  '.mode_name.'  %<%*%5*  %m%r'.filename.'  %*%h'.fugitive.'%=%6*  %Y  %*  %{&fileencoding} [%l/%L]'
    endif
endfunction

" INSERT (hotfix)
hi User1 ctermbg=1 ctermfg=7 cterm=bold
" NORMAL
hi User2 ctermbg=12 ctermfg=7 cterm=bold
" REPLACE (master)
hi User3 ctermbg=5 ctermfg=0
" VISUAL (devel)
hi User4 ctermbg=3 ctermfg=0

" ファイル名
hi User5 ctermbg=0 ctermfg=7 cterm=bold
" ファイルタイプ (feature)
hi User6 ctermbg=2 ctermfg=7 cterm=bold
" RO
hi User7 ctermbg=0 ctermfg=1

" Git用のステータスラインを設定する
" set statusline=%<%F\ %h%m%r%{fugitive#statusline()}%=%-14.(all=%L\ %l,%c%V%)\ \[ENC=%{&fileencoding}]%P
set statusline=%!MyStatusLine()
