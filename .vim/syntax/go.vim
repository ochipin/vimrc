" Vim syntax file
" Language: Go
" Maintainer: Suguru Ochiai
" Last Change: 2020 Dec 3

syn match addOperator "[!:=\+\-%&\/\*\>\<\|]"
highlight link addOperator Operator
hi Operator ctermfg=1 cterm=bold
syn match Brackets "[\(\)\[\]\{\}]"
hi Brackets ctermfg=6

" 予約語等の色の変更1 (1;01m)
hi Keyword ctermfg=4 cterm=none
" 数字の色を変更する
hi Number ctermfg=blue ctermbg=none cterm=none
" 文字列の色を変更する
hi String ctermfg=5 cterm=none
" 括弧のハイライトの色を変更
hi MatchParen ctermfg=cyan ctermbg=black cterm=none
" カーソルハイライトの色を変更
hi CursorColumn term=reverse ctermbg=black guibg=Grey90
