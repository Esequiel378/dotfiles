" Vim syntax file
" Language: eslang
" Maintainer: Esequiel Albornoz <esequielalbornoz@gmail.com>
" Last Change: Apr 1, 2022

if exists("b:current_syntax")
    finish
endif

echom "Eslang syntax highlighting on."

let b:current_syntax = "esl"

syntax match eslSpecialSymbol "+\|-\|\*\|<\|>\|&\||\|!\|%\|=\|\.\|\/"
hi link eslSpecialSymbol Operator

syn match eslComment '.*//.*$'
hi link eslComment Comment

syn match eslString '.*".*.".*'
hi link eslString String

syn keyword eslBuiltinKeyword while do if else end
hi link eslBuiltinKeyword Keyword

syn match eslVariable "\w\+"
hi link eslVariable Identifier

syn keyword eslBoolean true false
hi link eslBoolean Boolean

syn keyword eslType int float bool str nil
hi link eslType Type

syn keyword eslBuiltinFunction dup 2dup over 2over swap 2swap drop 2drop dump tuck rot -rot nip
hi link eslBuiltinFunction Function

syn match eslInterger "\(\d\{1,3}\)\(_\?\d\{1,3}\)*"
hi link eslInterger Number

syn match eslFloat "\d\+\.\d\+"
hi link eslFloat Number

