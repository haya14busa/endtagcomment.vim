"=============================================================================
" FILE: plugin/endtagcomment.vim
"=============================================================================
scriptencoding utf-8
" Load Once {{{
if expand("%:p") ==# expand("<sfile>:p")
    unlet! g:loaded_endtagcomment
endif
if exists('g:loaded_endtagcomment')
    finish
endif
let g:loaded_endtagcomment = 1
" }}}

" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}

let g:endtagcommentFormat = get(g:, 'endtagcommentFormat',
\                                   '<!-- /{%tag_name}{%id}{%class} -->')

nnoremap <Plug>(endtagcomment) :<C-u>call endtagcomment#Endtagcomment()<CR>

" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
unlet s:save_cpo
" }}}
" __END__  {{{
" vim: expandtab softtabstop=4 shiftwidth=4
" vim: foldmethod=marker
" }}}
