" ========== Custom statusline + mappings =======================
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2016-03-28
" ===============================================================

" The used plugins are:
" * Fugitive
" * GitGutter
" * Rvm
" * Syntastic
" * Unite

set noshowmode

" Get default CursorLineNR highlighting {{{1
redir => s:defaultCursorLineNr
	silent hi CursorLineNR
redir END
let s:defaultCursorLineNr = substitute(matchstr(s:defaultCursorLineNr, 'term.*'), "\n", '', 'g')
" 1}}}

" Configuration " {{{1
let s:SL  = {
			\ 'separator': '│',
			\ 'apply': {
				\ 'unite': 'unite#get_status_string()',
			\ },
			\ 'colors': {
				\ 'background'       : ['#222222','235'],
				\ 'backgroundLight'  : ['#393939','236'],
				\ 'blue'             : ['#6699cc','67'],
				\ 'green'            : ['#2acf2a','40'],
				\ 'red'              : ['#f01d22','160'],
				\ 'text'             : ['#cbcbcb','251'],
				\ 'textDark'         : ['#8c8c8c','244'],
				\ 'violet'           : ['#d09cea','171'],
				\ 'yellow'           : ['#ffbe3c','215'],
			\ },
			\ 'modes': {
				\ 'n': 'N',
				\ 'i': 'I',
				\ 'R': 'R',
				\ 'v': 'V',
				\ 'V': 'V-L',
				\ 'c': 'C',
				\ "\<C-v>": 'V-B',
				\ 's': 'S',
				\ 'S': 'S-L',
				\ "\<C-s>": 'S-B',
				\ '?': '',
			\ }
		\ }
" 1}}}

function! s:Hi(group, bg, fg, opt) abort " {{{1
	let l:bg = type(a:bg) ==# type('') ? ['none', 'none' ] : a:bg
	let l:fg = type(a:fg) ==# type('') ? ['none', 'none'] : a:fg
	let l:opt = empty(a:opt) ? ['none', 'none'] : [a:opt, a:opt]
	let l:mode = ['gui', 'cterm']
	let l:cmd = 'hi ' . a:group
	for l:i in (range(0, len(l:mode)-1))
		let l:cmd .= printf(' %sbg=%s %sfg=%s %s=%s',
					\ l:mode[l:i], l:bg[l:i],
					\ l:mode[l:i], l:fg[l:i],
					\ l:mode[l:i], l:opt[l:i]
					\ )
	endfor
	execute l:cmd
endfunction
" Highlighting {{{1
call s:Hi('SL1'      , s:SL.colors['yellow']          , s:SL.colors['background'] , 'bold')
call s:Hi('SL1I'     , s:SL.colors['green']           , s:SL.colors['background'] , 'bold')
call s:Hi('SL1R'     , s:SL.colors['red']             , s:SL.colors['text']       , 'bold')
call s:Hi('SL1V'     , s:SL.colors['blue']            , s:SL.colors['background'] , 'bold')
call s:Hi('SL2'      , s:SL.colors['backgroundLight'] , s:SL.colors['textDark']   , 'none')
call s:Hi('SL3'      , s:SL.colors['backgroundLight'] , s:SL.colors['text']       , 'none')
call s:Hi('SL4'      , s:SL.colors['yellow']          , s:SL.colors['background'] , 'none')
call s:Hi('Modified' , s:SL.colors['backgroundLight'] , s:SL.colors['yellow']     , 'bold')
hi! link StatusLine SL1
" 1}}}

" General items
function! SLFilename() abort " {{{1
	if has_key(s:SL.apply, &ft)
		return call(get(s:SL.apply, &ft)[:-3], [])
	endif
	if !empty(expand('%:t'))
		let l:fn = winwidth(0) <# 55 ?
					\ expand('%:t') :
					\ (winwidth(0) ># 85 ? expand('%:.') : pathshorten(expand('%:.')))
	else
		let l:fn = '[No Name]'
	endif
	return
				\ l:fn .
				\ (&readonly ? ' ' : '')
endfunction
function! SLModified() abort " {{{1
	return (&modified ? '+' : '')
endfunction
function! SLFileformat() abort " {{{1
	return winwidth(0) <# 55 ? '' :
				\ (winwidth(0) ># 85 ? &fileformat : &fileformat[0])
endfunction
function! SLFiletype() abort " {{{1
	return strlen(&filetype) ? &filetype : ''
endfunction
function! SLFileencoding() abort " {{{1
	return winwidth(0) <# 55 ? '' :
				\ (strlen(&fenc) ? &fenc : &enc)
endfunction
function! SLHiGroup() abort " {{{1
	return '➔ ' . synIDattr(synID(line('.'), col('.'), 1), 'name')
endfunction
function! SLMode() abort " {{{1
	return '▸ ' . get(s:SL.modes, mode())
endfunction
function! SLPaste() abort " {{{1
	return &paste ? '[PASTE]' : ''
endfunction
function! SLPython() abort " {{{1
	let l:p = executable('python') ?
				\ system('python --version')[7:-2] : ''
	let l:p3 = executable('python3') ?
				\ system('python3 --version')[7:-2] : ''
	return printf('[py %s - %s]', l:p, l:p3)
endfunction
function! SLSpell() abort " {{{1
	return &spell ?
				\ toupper(&spelllang[0]) . &spelllang[1:] : ''
endfunction
" 1}}}

" From Plugins
function! SLGitGutter() abort " {{{1
	if exists('g:gitgutter_enabled') && !empty(SLFugitive())
		let l:h = GitGutterGetHunkSummary()
		return printf("+%d ~%d -%d", l:h[0], l:h[1], l:h[2])
	else
		return ''
	endif
endfunction
function! SLFugitive() abort " {{{1
	return exists('*fugitive#head') && !empty(fugitive#head()) ?
				\ '  ' . fugitive#head() : ''
endfunction
function! SLRuby() abort " {{{1
	if has('gui_running')
		let l:r = exists('*rvm#statusline()') && !empty(rvm#statusline()) ?
					\ matchstr(rvm#statusline(), '\d.*[^\]]') : ''
	elseif executable('ruby')
		let l:r = matchstr(system('ruby -v')[5:], '[a-z0-9.]*\s')[:-2]
	else
		let l:r = ''
	endif
	return printf('[ruby %s]', l:r)
endfunction
function! SLSyntastic() abort " {{{1
	if exists('g:syntastic_mode_map') && g:syntastic_mode_map.mode ==# 'active'
			return !empty(SyntasticStatuslineFlag()) ?
							\ SyntasticStatuslineFlag() : ' '
	else
		return ''
	endif
endfunction
" 1}}}

" Helpers
function! SetSL() abort " {{{1
	let l:sl = ''

	" LEFT SIDE
	let l:sl .= ' %-{SLMode()} %(%{SLPaste()}%)'

	let l:sl .= '%(%#SL2#'
	let l:sl .= ' %{SLGitGutter()}'
	let l:sl .= ' %{SLFugitive()}'
	let l:sl .= '%)'

	let l:sl .= ' %#SL3#%{SLFilename()}'
	let l:sl .= '%(%#Modified# %{SLModified()}%)'

	" RIGHT SIDE
	let l:sl .= '%='

	let l:sl .= '%#SL2#'
	let l:sl .= '%(%{SLFiletype()} ' . s:SL.separator . '%)'
	let l:sl .= '%( %{SLSpell()} ' . s:SL.separator . '%)'
	" Percentage & line:column
	let l:sl .= ' %p%% %l:%c ' . s:SL.separator
	let l:sl .= '%('
	let l:sl .= ' %{SLFileencoding()}'
	let l:sl .= ' [%{SLFileformat()}] '
	let l:sl .= '%)'

	let l:sl .= '%(%#ErrorMsg# %{SLSyntastic()} %)'

	" Toggling part
	let l:sl .= '%#SL4#'
	return l:sl
endfunction
function! s:SetColorModeIR(mode) abort " {{{1
	if a:mode ==# 'i'
		hi! link StatusLine SL1I
	elseif a:mode ==# 'r'
		hi! link StatusLine SL1R
	else
		hi! link StatusLine SL1V
	endif
	hi! link CursorLineNR StatusLine
endfunction
function! s:SetColorModeV() abort " {{{1
	setl updatetime=1
	hi! link StatusLine SL1V
	hi! link CursorLineNR StatusLine
endfunction
function! s:ResetColorMode() abort " {{{1
	setl updatetime=4000
	call s:Hi('SL1', s:SL.colors['yellow'], s:SL.colors['background'], 'bold')
	execute 'hi CursorLineNR ' . s:defaultCursorLineNr
	hi! link StatusLine SL1
endfunction
function! <SID>ToggleSLItem(funcref, var) abort " {{{1
	if exists('*' . a:funcref)
		let l:item = '%( %{' . a:funcref . '} ' . s:SL.separator . '%)'
		if exists('g:{a:var}')
			unlet! g:{a:var}
			execute "set statusline-=" . escape(l:item, ' ')
		else
			let g:{a:var} = 1
			execute "set statusline+=" . escape(l:item, ' ')
		endif
	endif
endfunction
function! <SID>SLInit() abort " {{{1
	let &statusline = SetSL()
	augroup SLColor
		autocmd!
		autocmd InsertEnter * :call s:SetColorModeIR(v:insertmode)
		autocmd InsertLeave * :call s:ResetColorMode()
		autocmd CursorHold  * :call s:ResetColorMode()
	augroup END
	nnoremap <silent> v :call <SID>SetColorModeV()<CR>v
	nnoremap <silent> V :call <SID>SetColorModeV()<CR>V
	nnoremap <silent> <C-v> :call <SID>SetColorModeV()<CR><C-v>
endfunction
" 1}}}

" Mappings {{{1
nnoremap <silent> gsH  :call <SID>ToggleSLItem("SLHiGroup()", "sl_hi")<CR>
nnoremap <silent> gsR  :call <SID>ToggleSLItem("SLRuby()", "sl_ruby")<CR>
nnoremap <silent> gsP  :call <SID>ToggleSLItem("SLPython()", "sl_python")<CR>
nnoremap <silent> gsT  :call <SID>ToggleSLItem("strftime('%c')", "sl_time")<CR>
nnoremap <silent> gsS  :let &laststatus = (&laststatus !=# 0 ? 0 : 2)<CR>
" 1}}}

call <SID>SLInit()

" vim:ft=vim:fdm=marker:fmr={{{,}}}:
