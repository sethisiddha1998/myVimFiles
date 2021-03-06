" ==============================================================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2018-11-07
" ==============================================================


fun! ka#ui#echo(title, msg, ...) abort " {{{1
    let title = !empty(a:title) ? a:title . ' ' : ''
    let higroup = get(a:, 1, 'Normal')
    let keep_in_history = get(a:, 2, 0)

    redraw
    execute 'echohl ' . higroup
    if keep_in_history
        echomsg title . a:msg
        echohl None
    else
        echon title
        echohl None
        echon a:msg
    endif
endfun
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
