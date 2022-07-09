" Vim syntax file
" Language: gitignore
" Maintainer: Esequiel Albornoz <esequielalbornoz@gmail.com>
" Last Change: Jul 9, 2022

if exists("b:current_syntax")
    finish
endif

let b:current_syntax = "gitignore"

syntax match eslSpecialSymbol "+\|-\|\*\|<\|>\|&\||\|!\|%\|=\|\.\|\/"
hi link eslSpecialSymbol Operator

syn match eslComment '.*#.*$'
hi link eslComment Comment

syn keyword eslBoolean true false
hi link eslBoolean Boolean
