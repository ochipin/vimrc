" Gitプラグインの設定

" 保存時に、git diff表示を有効にする
if expand("%t") != ".git/COMMIT_EDITMSG"
    autocmd BufWritePost * :GitGutterEnable
endif

" Ctrl + l キーで git diff 表示
nnoremap <silent> <C-l> :GitGutterEnable<CR>

" Git用のステータスラインを設定する
set statusline=%<%F\ %h%m%r%{fugitive#statusline()}%=%-14.(all=%L\ %l,%c%V%)\ \[ENC=%{&fileencoding}]%P
