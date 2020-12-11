" 自動折り畳み機能は、 Markdown の時はしない
set nofoldenable

" 先頭のYAMLブロックを認識するようにする
let g:vim_markdown_frontmatter=1

" # ... ###### までの見出しスタイルを設定
hi mkdHeading ctermfg=4 cterm=none
hi htmlH1 ctermfg=4 cterm=none
hi htmlH2 ctermfg=4 cterm=none
hi htmlH3 ctermfg=4 cterm=none
hi htmlH4 ctermfg=4 cterm=none
hi htmlH5 ctermfg=4 cterm=none
hi htmlH6 ctermfg=4 cterm=none

" *, 1 2, 3 などのリストスタイルを設定
hi mkdListItem ctermfg=3 cterm=bold

" URLリンクの色
hi htmlLink ctermfg=7 cterm=underline
hi htmlString ctermfg=7 cterm=underline

" 括弧やエクスクラメーションなどの文字色を変更
hi Delimiter ctermfg=6 cterm=bold

" 太字・イタリックのスタイルを設定
hi htmlBold ctermfg=3 cterm=none
hi htmlItalic ctermfg=2 cterm=bold
