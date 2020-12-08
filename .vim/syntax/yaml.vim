" Vim syntax file
" Language: YAML
" Maintainer: Suguru Ochiai
" Last Change: 2020 Dec 8

hi String ctermfg=5 cterm=none ctermbg=none
hi Identifier ctermfg=2 cterm=bold ctermbg=none
" 予約語等の色の変更1 (1;01m)
hi Comment ctermfg=2 cterm=none ctermbg=none
" 数字の色を変更する
hi Number ctermfg=4 ctermbg=none cterm=none
" 文字列の色を変更する
hi Label ctermfg=1 cterm=none
hi Special ctermfg=1 cterm=bold
" 括弧のハイライトの色を変更
hi MatchParen ctermfg=cyan ctermbg=black cterm=none
" カーソルハイライトの色を変更
hi CursorColumn term=reverse ctermbg=black guibg=Grey90
