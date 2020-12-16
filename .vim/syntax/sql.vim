" 大文字、小文字を無視する
syn case ignore

" PostgregreSQLに対応したキーワードや、型を定義する
syn keyword pqKeyword CONSTRAINT PRIMARY KEY SCHEMA ROLE LOGIN NOLOGIN LIMIT PASSWORD DATABASE USAGE
syn keyword pqType int int8 int16 int32 int64 bigint timestamp text
hi def link pqType Type

" それぞれ色を付ける
hi pqKeyword ctermfg=2 cterm=bold
hi Type ctermfg=3 cterm=none
hi Number ctermfg=4 cterm=none
" 括弧の色
hi MatchParen ctermfg=cyan ctermbg=black cterm=none
