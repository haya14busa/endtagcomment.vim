"=============================================================================
" FILE: autoload/endtagcomment.vim
"=============================================================================
scriptencoding utf-8
" Saving 'cpoptions' {{{
let s:save_cpo = &cpo
set cpo&vim
" }}}

" Description"{{{
" Before
" <div id="hoge" class="fuga">
" ...
" </div>
"
" After
" <div id="hoge" class="fuga">
" ...
" </div><!-- /div#hoge.fuga -->
"}}}

function! endtagcomment#Endtagcomment() "{{{
    let reg_save = @@

    try
        silent normal! vaty
    catch
        execute "normal! \<Esc>"
        echohl ErrorMsg
        echo 'no match html tags'
        echohl None
        return
    endtry

    let html = @@

    let start_tag = matchstr(html, '\v(\<.{-}\>)')
    let tag_name  = matchstr(start_tag, '\v([a-zA-Z]+)')

    let id = ''
    let id_match = matchlist(start_tag, '\vid\=["'']([^"'']+)["'']')
    if exists('id_match[1]')
        let id = '#' . id_match[1]
    endif

    let class = ''
    let class_match = matchlist(start_tag, '\vclass\=["'']([^"'']+)["'']')
    if exists('class_match[1]')
        let class = '.' . join(split(class_match[1], '\v\s+'), '.')
    endif

    execute "normal! `>va<\<Esc>`<"

    let comment = g:endtagcommentFormat
    let comment = substitute(comment, '{%tag_name}', tag_name, 'g')
    let comment = substitute(comment, '{%id}', id, 'g')
    let comment = substitute(comment, '{%class}', class, 'g')
    let @@ = comment

    normal! %""p

    let @@ = reg_save
endfunction "}}}


" Restore 'cpoptions' {{{
let &cpo = s:save_cpo
unlet s:save_cpo
" }}}
" __END__  {{{
" vim: expandtab softtabstop=4 shiftwidth=4
" vim: foldmethod=marker
" }}}
