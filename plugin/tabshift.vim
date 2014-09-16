" vim plugin file
" Filename:     tabshift.vim
" Maintainer:   janus_wel <janus.wel.3@gmail.com>
" License:      MIT License {{{1
"   See under URL.  Note that redistribution is permitted with LICENSE.
"   https://github.com/januswel/tabshift.vim/blob/master/LICENSE

" preparations {{{1
" check if this plugin is already loaded or not
if exists('loaded_tabshift')
    finish
endif
let loaded_tabshift = 1

" check vim has required features
if !has('windows')
    finish
endif

" reset the value of 'cpoptions' for portability
let s:save_cpoptions = &cpoptions
set cpoptions&vim

" main {{{1
" commands {{{2
if exists(':TabShift') != 2
    command -nargs=1 -bang TabShift
                \ call <SID>TabShift('<bang>', <args>)
endif

" functions {{{2
function! s:TabShift(bang, delta)
    " assertion
    " suppose the delta is a Number
    if type(a:delta) != 0
        echoerr 'A Number is required: ' . a:delta
        return
    endif

    " calculate new position
    let numoftab = tabpagenr('$')
    let pos = tabpagenr() + a:delta - 1

    " fine tunings
    if a:bang ==# '!'
        " wrap-around
        let pos = pos % numoftab
        if pos < 0
            let pos += numoftab
        endif
    else
        if pos < 0
            let pos = 0
        elseif numoftab <= pos
            let pos = numoftab - 1
        endif
    endif

    execute 'tabmove' pos
endfunction

" post-processings {{{1
" restore the value of 'cpoptions'
let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions

" }}}1
" vim: ts=4 sw=4 sts=0 et fdm=marker fdc=3
