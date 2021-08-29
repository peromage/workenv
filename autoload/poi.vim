""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Poi core initializer
"
" Created by peromage 2021/02/23
" Last modified 2021/03/18
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists('g:loaded_poi')
    finish
endif
let g:loaded_poi = 1

"-------------------------------------------------------------------------------
" Meta
"-------------------------------------------------------------------------------
" poi root directory
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

"-------------------------------------------------------------------------------
" Helper functions
"-------------------------------------------------------------------------------
" Load script from poi home. Path should be relative
" This file throws errors if the file does not exists
function! poi#include(rel_path) abort
    execute 'source '. fnameescape(s:home . '/' . a:rel_path)
endfunction

" Initialize global variable if it doesn't exist
" NOTE: The g: should be ommitted when passed to this function
function! poi#init_var(name, value) abort
    let l:gvar = 'g:' . a:name
    if !exists(l:gvar)
        execute 'let ' . l:gvar . '=' . string(a:value)
    endif
endfunction

" Check if the given global variable exists and enabled
" NOTE: The g: should be ommitted when passed to this function
function! poi#check_var(name) abort
    let l:gvar = 'g:' . a:name
    return exists(l:gvar) && eval(l:gvar)
endfunction

" Returns a boolean indicating if the variable with the given name exists and
" the type of the value is represented as non-empty. Results will be stored in
" the out dict
" NOTE: The g: should be ommitted when passed to this function
function! poi#get_var_non_empty(name, out_dict) abort
    let l:value = get(g:, a:name, v:null)
    let a:out_dict.name = 'g:'.a:name
    let a:out_dict.value = l:value
    let a:out_dict.valid = !empty(l:value)
    return a:out_dict.valid
endfunction

" Returns a boolean indicating if the variable with the given name exists
" Results will be stored in the out dict
" NOTE: The g: should be ommitted when passed to this function
function! poi#get_var(name, out_dict) abort
    let l:value = get(g:, a:name, v:null)
    let a:out_dict.name = 'g:'.a:name
    let a:out_dict.value = l:value
    let a:out_dict.valid = l:value isnot v:null
    return a:out_dict.valid
endfunction

" Returns a boolean indicating if the file exists
function! poi#file_exists(path) abort
    return len(glob(a:path))
endfunction

" Source any file from anywhere only if it exists
" This function does not throw errors if file does not exist
function! poi#source_if_exits(path) abort
    if poi#file_exists(a:path)
        execute 'source ' . a:path
    endif
endfunction

"-------------------------------------------------------------------------------
" Helper commands
"-------------------------------------------------------------------------------
command! -nargs=1 PoiInclude call poi#include("viml/<args>.vim")
command! -nargs=1 PoiSourceIfExists call poi#source_if_exits("<args>")

"-------------------------------------------------------------------------------
" Initializers
"-------------------------------------------------------------------------------
" Loading protection flag
let s:loading = 0

function! poi#begin(...) abort
    let s:loading = 1
    " Directory to put plugin and plugin configuration (e.g. vim-plug, Coc)
    let l:data_dir = a:0 > 0 ? a:1 : s:home
    call plug#begin(simplify(l:data_dir . '/vim-plugged'))
    let g:coc_data_home = simplify(l:data_dir . '/coc-extensions')
    let g:coc_config_home = l:data_dir
endfunction

function! poi#end() abort
    " Begin function must be called
    if !s:loading
        echoe 'poi#begin() must be called first!'
        return
    endif
    call plug#end()
    let s:loading = 0
endfunction

function! poi#gui_init() abort

endfunction
