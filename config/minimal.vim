" ========== Minimal vimrc without plugins (Unix & Windows) ======
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2017-08-25
" ================================================================


" ========== MISC  ===========================================

" Unsure to use french locale if it exists {{{1
let s:curr_locale = v:lang
try
	language fr_FR.utf8
catch /^Vim\%((\a\+)\)\=:E197/
	silent execute 'language ' . s:curr_locale
endtry
unlet! s:curr_locale
" Load indentation rules and plugins according to the detected filetype {{{1
filetype plugin indent on
" Enables syntax highlighting {{{1
syntax on
" What to write in Viminfo and his location {{{1
execute "set vi='100,<50,s10,h,n" . g:vimDir . "/misc/viminfo"
" Add the file systags to the tags option {{{1
execute 'set tags+=' . g:vimDir . '/misc/systags'
" Using a dark background {{{1
set background=dark
" Disable Background Color Erase (BCE) so that color schemes work properly {{{1
" when Vim is used inside tmux and GNU screen.
if exists('$TMUX')
	set t_ut=
endif
" Tmux will send xterm-style keys when its xterm-keys option is on. {{{1
if &term =~# '^screen'
	execute "set <xUp>=\e[1;*A"
	execute "set <xDown>=\e[1;*B"
	execute "set <xRight>=\e[1;*C"
	execute "set <xLeft>=\e[1;*D"
endif
" Directory where to store files with :mkview. {{{1
execute 'set viewdir=' . g:vimDir . '/misc/view'
" Make <Alt> works in terminal. {{{1
" http://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim/10216459#10216459
if !empty($TERM)
	let s:c = 'a'
	while s:c <=# 'z'
		exec "set <A-" . s:c . ">=\e" . s:c
		exec "imap \e" . s:c . " <A-" . s:c . ">"
		let s:c = nr2char(1 + char2nr(s:c))
	endwhile
	unlet s:c
endif
" }}}

" ========== OPTIONS  ===========================================

" >>> GUI {{{1
let &guioptions = 'agirtc'
set winaltkeys=no	" Don't use ALT-keys for menus.
set linespace=5
let &guifont = g:hasWin ?
			\ 'InconsolataForPowerline NF Medium:h10:cANSI' :
			\ 'InconsolataForPowerline NF Medium 13'
" >>> Messages & info {{{1
set showcmd
set ruler
set confirm		" Start a dialog when a command fails
" >>> Edit text {{{1
set infercase						" Adjust case of a keyword completion match.
set completeopt=menuone				" Use only a popup menu without preview.
set textwidth=0						" Don't insert automatically newlines
if g:hasWin
	set backspace=2					" Make backspace works normally in Win
endif
set matchpairs+=<:>
" >>> Display text {{{1
set number
set linebreak
let &showbreak='⤷ '
set scrolloff=3			" Number of screen lines to show around the cursor.
set display=lastline	" Show the last line even if it doesn't fit.
set lazyredraw			" Don't redraw while executing macros
set breakindent			" Preserve indentation in wrapped text
" Make stars and bars visible
hi! link HelpBar Normal
hi! link HelpStar Normal
let &listchars = g:hasWin ?
			\ 'tab:| ,trail:~,extends:>,precedes:<' :
			\ 'tab:| ,trail:~,extends:#,nbsp:.'
set list
" Scroll horizontally by 1 character (Only when wrap is disabled).
set sidescroll=1
" >>> Reading and writing files {{{1
set modeline
" >>> Move, search & patterns {{{1
set ignorecase
set smartcase
set incsearch					" Incremental search.
" List of flags specifying which commands wrap to another line.
set whichwrap=b,s,<,>,[,]
" >>> Running make and jumping to errors {{{1
let s:grepPrg = '%s -S --vimgrep $*'
let s:grepFormat = '%f:%l:%c:%m'
if executable('rg')
	let &grepprg = printf(s:grepPrg, 'rg')
	let &grepformat = s:grepFormat
elseif executable('ag')
	let &grepprg = printf(s:grepPrg, 'ag')
	let &grepformat = s:grepFormat
endif
unlet! s:grepPrg s:grepFormat
" >>> Syntax, highlighting and spelling {{{1
set cursorline
set hlsearch
set spelllang=fr
set synmaxcol=200	" Max column to look for syntax items
" >>> Tabs & indenting {{{1
set tabstop=4			" Number of spaces a <Tab> in the text stands for.
set softtabstop=4		" Number of spaces to insert for a <Tab>.
set shiftwidth=4		" Number of spaces used for each step of (auto)indent.
set smarttab			" A <Tab> in an indent inserts 'shiftwidth' spaces.
set autoindent			" Automatically set the indent of a new line.
set copyindent			" Copy whitespace for indenting from previous line.
" >>> Folding {{{1
set foldcolumn=1	" Width of the column used to indicate fold.
" >>> Command line editing {{{1
" Command <Tab> completion, list matches, then longest common part, then all.
set wildmode=list:longest,full
set wildmenu
" Enable the persistent undo.
if has('persistent_undo')
	let &undodir = g:vimDir . '/misc/undodir/'
	set undofile
endif
" >>> Multi-byte characters {{{1
set encoding=utf-8
" >>> Multiple windows {{{1
set splitright		" A new window is put right of the current one.
set hidden
" >>> Swap file {{{1
" Set the swap file directories.
let &directory = g:hasWin ?
			\ g:vimDir . '\\misc\\swap_dir,c:\\tmp,c:\\temp\\' :
			\ g:vimDir . '/misc/swap_dir,~/tmp,/var/tmp,/tmp\'
" >>> Mapping {{{1
" Remove the delay when escaping from insert-mode in terminal
if !g:hasGui
	set timeoutlen=1000 ttimeoutlen=0
endif
" >>> Executing external commands {{{1
" Allows using shell aliases & functions
" if g:hasGui
" 	let &shell = '/bin/bash -i'
" endif
" }}}

" =========== DEFAULT PLUGINS ===================================

" Disable non-used default plugins {{{1
let g:loaded_2html_plugin = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_matchparen = 1
let g:loaded_netrwPlugin = 1
let g:loaded_tarPlugin= 1
let g:loaded_vimballPlugin = 1
let g:loaded_zipPlugin = 1
" }}}

" =========== MAPPINGS ==========================================

" >>> Make movements after f mappings family more convenient {{{1
" (And because I use , and ; a lot).
for s:k in ['f', 'F', 't', 'T']
	execute 'nnoremap ' . s:k . '<CR> ;'
	execute 'nnoremap ' . s:k . '<BS> ,'
endfor
unlet! s:k
" >>> Make Y work as other capitals {{{1
nnoremap Y y$
" >>> Duplicate selection {{{1
" *** yd to duplicate line in NORMAL mode witout moving cursor
" *** <C-d> to duplicate selection in VISUAL mode.
nnoremap <silent> yd :call <SID>Duplicate()<CR>
vnoremap <silent> <C-d> :t'><CR>gv<Esc>
function! s:Duplicate() abort
	let l:ip = getpos('.') | silent .t. | call setpos('.', l:ip)
endfunction
" >>> Open or close the fold {{{1
nnoremap <silent> <space> za
vnoremap <silent> <space> :fold<CR>
" >>> Search {{{1
nnoremap <silent> ghh :nohlsearch<CR>
nnoremap <silent> * *N
nnoremap / /\V
nnoremap ? ?\V
nnoremap n nzz
nnoremap N Nzz
" >>> Operations on tabs {{{1
nnoremap <silent> <C-t> :tabedit<CR>
nnoremap <silent> <F5> :tabonly<CR>
" >>> Operations on buffers {{{1
nnoremap <silent> <S-h> :silent bp!<CR>
nnoremap <silent> <S-l> :silent bn!<CR>
nnoremap <silent> <BS> <C-^>
" For this mapping, check NERDTree settings in config/plugins.vim
nnoremap <silent> <S-q> :silent bw<CR>
" >>> Repeat the last command {{{1
nnoremap !z @:
" >>> JK for escape from INSERT & COMMAND modes {{{1
inoremap jk <Esc>
inoremap JK <Esc>
cnoremap jk <C-c>
cnoremap JK <Esc>
" >>> For splits {{{1
nnoremap <silent> gs <C-w>
nnoremap <silent> gsnv :vnew<CR>
nnoremap <silent> gsns :split +enew<CR>
nnoremap <silent> <C-Up> <C-w>+
nnoremap <silent> <C-Down> <C-w>-
nnoremap <silent> <Up> <C-w>K
nnoremap <silent> <Down> <C-w>J
nnoremap <silent> <Right> <C-w>L
nnoremap <silent> <Left> <C-w>H
if g:hasGui
	nnoremap <silent> <c-h> <C-w><Left>
	nnoremap <silent> <c-j> <C-w><Down>
	nnoremap <silent> <c-k> <C-w><Up>
	nnoremap <silent> <c-l> <C-w><Right>
else
	nnoremap <silent> <c-h> :call <SID>TmuxMove('h')<CR>
	nnoremap <silent> <c-j> :call <SID>TmuxMove('j')<CR>
	nnoremap <silent> <c-k> :call <SID>TmuxMove('k')<CR>
	nnoremap <silent> <c-l> :call <SID>TmuxMove('l')<CR>
endif
" Move between splits & tmux " {{{2
" https://gist.github.com/mislav/5189704#gistcomment-1735600
function! s:TmuxMove(direction) abort
	let l:wnr = winnr()
	silent! execute 'wincmd ' . a:direction
	" If the winnr is still the same after we moved, it is the last pane
	if l:wnr ==# winnr()
		call system('tmux select-pane -' . tr(a:direction, 'phjkl', 'lLDUR'))
	endif
endfunction " 2}}}
" >>> For command line {{{1
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-j> <Left>
cnoremap <C-k> <Right>
cnoremap <C-h> <C-Left>
cnoremap <C-l> <C-Right>
cnoremap <C-a> <Home>
" >>> Sort {{{1
vnoremap <silent> <leader>s :!sort<CR>
nnoremap <silent> <leader>s <Esc>:setlocal operatorfunc=<SID>Sort<CR>g@
function! s:Sort(...) abort
	execute printf('%d,%d:!sort', line("'["), line("']"))
endfunction
" >>> Movement {{{1
" Move by paragraph ({ & } are quite difficult to reach in azerty layout)
nnoremap J }
nnoremap K {
" Make j and k move to the next row, not file line
nnoremap j gj
nnoremap k gk
" >>> Quickly edit macro or register content in scmdline-window {{{1
" (https://github.com/mhinz/vim-galore)
" e.g. "q\r
nnoremap <leader>r :<c-u><c-r>='let @'. v:register 
			\ .' = '. string(getreg(v:register))<cr><c-f><left>
" >>> Open URL {{{1
nnoremap <silent> gx :call helpers#OpenUrl()<CR>
" >>> For marks {{{1
nnoremap <silent> m<space> :delmarks!<CR>
" >>> Open here terminal/file manager {{{1
nnoremap <silent> ;t   :call helpers#OpenHere('t')<CR>
nnoremap <silent> ;;t  :call helpers#OpenHere('t', expand('%:h:p'))<CR>
nnoremap <silent> ;f   :call helpers#OpenHere('f')<CR>
nnoremap <silent> ;;f  :call helpers#OpenHere('f', expand('%:h:p'))<CR>
" >>> Move current line or visual selection & auto indent {{{1
nnoremap <silent> <A-k> :call <SID>Move(-1)<CR>==
nnoremap <silent> <A-j> :call <SID>Move(1)<CR>==
vnoremap <silent> <A-k> :call <SID>Move(-1)<CR>gv=gv
vnoremap <silent> <A-j> :call <SID>Move(1)<CR>gv=gv
function! s:Move(to) range " {{{2
	" a:to : -1/1 <=> up/down

	let l:fl = a:firstline | let l:ll = a:lastline
	let l:to = a:to ==# -1 ?
				\ l:fl - 2 :
				\ (l:ll + 1 >=# line('$') ? line('$') : l:ll + 1)
	execute printf(':%d,%dm%d', l:fl, l:ll, l:to)
	let l:cl = line('.')
	if foldlevel(l:cl) !=# 0
		normal! zaza
	endif
endfunction " 2}}}
" >>> Use c for manipulating + register {{{1
nnoremap cd "+d
nnoremap cp "+p
nnoremap cP "+P
nnoremap cy "+y
nnoremap cY "+y$
vnoremap Cd "+d
vnoremap Cp "+p
vnoremap CP "+P
vnoremap Cy "+y
" >>> Text objects {{{1
" All ***
"	- ie         : Entire file
"	- il         : Current line without whitespace
"	- i{X}/a{X}  : Inside/around {X}
"					* dots
"					* commas
"					* underscores
"					* stars
"					* #, :, +, -, /, =
" Scss/Css ***
"	 - iV     : Value
"	 - iP     : Property
"	 - if/af  : Inside/around a selector block
" Sh ***
"	 - if/af  : Inside/around a function
let s:to = {
			\	'_' : [
			\			['ie', 'ggVG'],
			\			['il', '^vg_'],
			\			['i.', 'F.WvEf.ge'],
			\			['a.', 'F.vEf.'],
			\			['i_', 'T_vt_'],
			\			['a_', 'F_vf_'],
			\			['i*', 'T*vt*'],
			\			['a*', 'F*vf*'],
			\			['i,', 'T,vt,'],
			\			['a,', 'F,vf,'],
			\			['i#', 'T#vt#'],
			\			['a#', 'F#vf#'],
			\			['i:', 'T:vt:'],
			\			['a:', 'F:vf:'],
			\			['i+', 'T+vt+'],
			\			['a+', 'F+vf+'],
			\			['i-', 'T-vt-'],
			\			['a-', 'F-vf-'],
			\			['i/', 'T/vt/'],
			\			['a/', 'F/vf/'],
			\			['i=', 'T=vt='],
			\			['a=', 'F=vf='],
			\	],
			\	'scss,css' : [
			\		['iV', '^f:wvt;'],
			\		['iP', '^f:Bvt:'],
			\		['if', '][kvi{V'],
			\		['af', '][kva{Vo[]j'],
			\	],
			\	'sh' : [
			\		['if', 'vi{V'],
			\		['af', 'va{V'],
			\	]
			\ }
call helpers#MakeTextObjects(s:to)
unlet! s:to
" >>> Enable Paste when using <C-r> in INSERT mode {{{1
inoremap <silent> <C-r> <C-r><C-p>
" >>> Preview {{{1
nnoremap <silent> gPr :Preview<CR>
vnoremap <silent> gPr :Preview<CR>
nnoremap <silent> gaPr :call helpers#AutoCmd(
			\	'Preview', 'Preview',
			\	['BufWritePost,InsertLeave,TextChanged,CursorHold,CursorHoldI']
			\ )<CR>
" >>> Toggle options {{{1
nnoremap <silent> <leader><leader>n :setl number!<CR>
nnoremap <silent> <leader><leader>w :setl wrap!<CR>
nnoremap <silent> <leader><leader>l :setl list!<CR>
nnoremap <silent> <leader><leader>f :set fo-=o fo-=c fo-=r<CR>
nnoremap <silent> <leader><leader>c :execute 'setl colorcolumn=' . (&cc ? '' : 81)<CR>
" >>> Grep {{{1
" To use with ag
nnoremap ,,g :call <SID>Grep()<CR>
xnoremap <silent> ,,g :call <SID>Grep(1)<CR>
nnoremap <silent> ,g <Esc>:setlocal operatorfunc=<SID>GrepMotion<CR>g@
function! s:Grep(...) abort " {{{2
	if exists('a:1')
		let l:q = a:1 ==# 1 ?
					\	helpers#GetVisualSelection() :
					\	helpers#GetMotionResult()
	else
		echohl ModeMsg | let l:q = input('grep> ') | echohl None
	endif
	" Escape spaces in strings between double quotes then delete them
	let l:q = substitute(l:q, '\v(".*")', '\=escape(submatch(1), " ")', 'g')
	let l:q = substitute(l:q, '"', '', 'g')
	" Escape special spaces & characters
	let l:q = map(split(l:q, ' '), 'escape(v:val, "%# ")')
	if !empty(l:q)
		silent execute 'grep! ' . join(l:q, ' ') | botright copen 10 | wincmd p
		redraw!
	endif
endfunction
function! s:GrepMotion(...) abort " {{{2
	call <SID>Grep(2)
endfunction " 2}}}
" >>> Reselect visual selection after (in/de)creasing numbers {{{1
xnoremap <C-a> <C-a>gv
xnoremap <C-x> <C-x>gv
" 1}}}

" =========== (AUTO)COMMANDS ==============================

" >>> Indentation for specific filetypes {{{1
augroup Indentation
	autocmd!
	autocmd FileType coffee,html,css,scss,pug,vader,ruby,markdown
				\ setl ts=2 sts=2 sw=2 expandtab
	autocmd FileType python,json
				\ setl ts=4 sts=4 sw=4 expandtab
augroup END
" >>> Make cursor line appear only in active window {{{1
augroup CursorLine
	autocmd!
	autocmd WinEnter * set cursorline
	autocmd WinLeave * set nocursorline
augroup END
" >>> Commands for folders & files {{{1
command! -nargs=+ -complete=file Mkdir  :call helpers#MakeDir(<f-args>)
command! -nargs=+ -complete=file Rm     :call helpers#Delete(<f-args>)
command! -nargs=1 -complete=file Rename :call helpers#Rename(<f-args>)
" >>> Specify indentation (ts,sts,sw) {{{1
command! Indent :call <SID>SetIndentation()
function! s:SetIndentation() abort " {{{2
	let l:indentation = input('New indentation (' . &ts . ', ' . &sts . ', ' . &sw . ') => ')
	if l:indentation !=# ''
		execute 'setl ts=' . l:indentation
		execute 'setl sts=' . l:indentation
		execute 'setl sw=' . l:indentation
	endif
endfunction " 2}}}
" >>> Shortcuts for vim doc {{{1
command! Hl :help local-additions
command! Fl :help function-list
" >>> Change file type between PHP and HTML files {{{1
augroup ChPhpHtml
	autocmd!
	autocmd FileType php,html command! -buffer Ch :execute 'setf ' . (&ft ==# 'php' ? 'html' : 'php')
augroup END
" >>> Conversion between TABS ans SPACES {{{1
command! TabToSpace :setlocal expandtab | %retab!
command! SpaceToTab :setlocal noexpandtab | %retab!
" >>> Make the current file directory as the vim current directory {{{1
command! Dir :cd %:p:h
" >>> Write to file with sudo (Linux only) {{{1
" http://www.jovicailic.org/2015/05/saving-read-only-files-in-vim-sudo-trick/
if g:hasUnix
	command! SudoW :w !sudo tee % >/dev/null
endif
" >>> Set spelllang & spell in one command {{{1
command! -nargs=? Spell call <SID>SetSpell(<f-args>)
function! s:SetSpell(...) abort " {{{2
	let l:l = exists('a:1') ? a:1 : 'fr'
	execute 'setlocal spelllang=' . l:l
	setlocal spell!
endfunction " 2}}}
" >>> Enable marker folding for some ft {{{1
augroup AutoFold
	autocmd!
	autocmd BufEnter *.js,*.sh,*.css
				\ setlocal foldmethod=marker
				\| setlocal foldmarker=\ {,}
				\| normal! zR
augroup END
" >>> Echo vim expression in a buffer __Echo__ {{{1
command! -nargs=* -complete=expression Echo :call <SID>Echo(<f-args>)
function! s:Echo(...) abort " {{{2
	let l:out = ''
	redir => l:out
	silent execute 'echo ' . join(a:000, '')
	redir END
	if !empty(l:out[1:])
		call helpers#OpenOrMove2Buffer('__Echo__', 'vim', 'sp')
		call setline(1, l:out[1:])
		wincmd p
	endif
endfunction " 2}}}
" >>> Preview buffer {{{1
" TODO: Find a way to execute vimscript.
command! -range=% Preview :call <SID>Preview(<line1>, <line2>)
function! s:Preview(start, end) abort " {{{2
	call helpers#ExecuteInBuffer('__Preview__', a:start, a:end, {
				\	'c'         : {'cmd': 'gcc -o %o.out %i.c', 'tmp': 1, 'exec': 1},
				\	'coffee'    : {'cmd': 'coffee -spb', 'ft': 'javascript'},
				\	'cpp'       : {'cmd': 'g++ -o %o.out %i.c', 'tmp': 1, 'exec': 1},
				\	'javascript': {'cmd': 'nodejs'},
				\	'lua'       : {'cmd': 'lua'},
				\	'markdown'  : {'cmd': 'markdown', 'ft': 'html'},
				\	'php'       : {'cmd': 'php'},
				\	'pug'       : {'cmd': 'pug --pretty', 'ft': 'html'},
				\	'python'    : {'cmd': 'python3'},
				\	'ruby'      : {'cmd': 'ruby'},
				\	'scss'      : {'cmd': 'node-sass --output-style=expanded', 'ft': 'css'},
				\	'sh'        : {'cmd': 'bash'},
				\ })
endfunction " 2}}}
" >>> Persistent scratch buffer {{{1
command! Scratch :call s:Scratch()
function! s:Scratch() abort " {{{2
	call helpers#OpenOrMove2Buffer('__Scratch__', 'markdown', 'topleft sp')
	if exists('g:scratch')
		silent %delete_
		call append(0, g:scratch)
	else
		augroup Scratch
			autocmd!
			autocmd InsertLeave,CursorHold,CursorHoldI,TextChanged __Scratch__ :let g:scratch = getline(1, line('$'))
		augroup END
	endif
endfunction " 2}}}
" >>> Chmod current file {{{1
command! ChmodX :!chmod +x %
" >>> Auto mkdir when creating/saving file {{{1
function! s:AutoMkdir() abort " {{{2
	let l:dir = expand('<afile>:p:h')
	let l:file = expand('<afile>:t')
	if !isdirectory(l:dir)
		echohl WarningMsg
		let l:ans = input(l:dir . ' does not exist, create it [Y/n]? ')
		echohl None
		if empty(l:ans) || l:ans ==# 'y'
			let l:old_b = bufnr('%') + 1
			call mkdir(l:dir, 'p')
			silent execute 'saveas ' . l:dir . '/' . l:file
			silent execute 'bw ' . l:old_b
		endif
	endif
endfunction " 2}}}
augroup AutoMkdir
	autocmd!
	autocmd BufWritePre * call <SID>AutoMkdir()
augroup END
" >>> For quickfix/location windows {{{1
augroup Quickfix
	autocmd!
	autocmd FileType qf setl nowrap
	autocmd FileType qf nnoremap <buffer> <CR> <CR><C-w>p
augroup END
" >>> Disable continuation of comments when using o/O {{{1
augroup FormatOpt
	autocmd!
	autocmd FileType * setl fo-=o fo-=c fo-=r
	" To make it work on vim ft damn it!
	autocmd InsertEnter * setl fo-=o fo-=c fo-=r
augroup END
" 1}}}

" =========== JOBS ==============================

" Command for executing external tools using vim jobs {{{1
if g:hasJob
	command! KillJobs call helpers#KillAllJobs()
	" Live-server
	if executable('live-server')
		command! LiveServer call helpers#Job('liveServer', 'live-server')
	endif
	" Browser-sync
	if executable('browser-sync')
		command! -nargs=* BrowserSync call helpers#Job(
					\	'browserSync',
					\	<SID>BrowserSync(<f-args>)
					\ )
		function! s:BrowserSync(...) abort " {{{2
			let l:cwd = getcwd()
			let l:files = exists('a:1') ?
						\	join(map(split(a:1, ','), 'l:cwd . "/" . v:val'), ',') :
						\	printf('%s/*.html,%s/*.css,%s/*.js', l:cwd, l:cwd, l:cwd)
			let l:opts = exists('a:2') ? a:2 : '--directory --no-online'
			return printf(
						\ "browser-sync start --server --files=%s %s",
						\ l:files, l:opts
						\ )
		endfunction " 2}}}
	endif
endif
" 1}}}

" =========== ABBREVIATIONS ==============================

" No more rage {{{1
cab W! w!
cab Q! q!
cab QA! qa!
cab QA qa
cab Wq wq
cab wQ wq
cab WQ wq
cab W w
cab Q q
" 1}}}

" =========== OMNIFUNC ==============================

" Set omni-completion if the appropriate syntax file is present otherwise {{{1
" use the syntax completion
augroup Omni
	autocmd!
	if exists('+omnifunc')
		autocmd! Filetype *
					\ if &omnifunc ==# '' |
					\	setlocal omnifunc=syntaxcomplete#Complete |
					\ endif
	endif
augroup END
" 1}}}

" =========== EXTERNAL APPLICATIONS INTEGRATION ==============================

" >>> Use Shiba with some file types {{{1
if executable('shiba')
	augroup Shiba
		autocmd!
		autocmd Filetype html,markdown command! -buffer Shiba :silent exe '!shiba --detach %' | redraw!
	augroup END
endif
" >>> Cmus {{{1
if executable('cmus')
	let s:cmusCmds = {
				\	'play'      : 'p',
				\	'pause'     : 'u',
				\	'stop'      : 's',
				\	'next'      : 'n',
				\	'previous'  : 'r',
				\	'repeat'    : 'R',
				\	'shuffle'   : 'S',
				\ }
	command! -nargs=? -bar -complete=custom,<SID>CompleteCmus Cmus :call <SID>Cmus('<args>')
	function! s:Cmus(...) abort " {{{2
		let l:arg = exists('a:1') && !empty(get(s:cmusCmds, a:1)) ?
					\ get(s:cmusCmds, a:1) : 'u'
		silent call system('cmus-remote -' . l:arg)
		" Get the value of a:1 if it exists...
		let l:Q = filter(systemlist('cmus-remote -Q'), 'v:val =~# "^set " . a:1 . " "')
		" ... then show it
		if !empty(l:Q)
			echo l:Q[0][4:]
		endif
	endfunction " 2}}}
	function! s:CompleteCmus(A, L, P) abort " {{{2
		return join(keys(s:cmusCmds), "\n")
	endfunction " 2}}}
endif
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
