" ========== Vim plugins configurations (Unix & Windows) =========
" Kabbaj Amine - amine.kabb@gmail.com
" Last modification: 2017-09-02
" ================================================================


" My plugins {{{1
let s:labMode = 0
let s:myPluginsDir = g:hasWin ?
			\ 'z:\\k-bag\\Projects\\pluginsVim\\' :
			\ $HOME . '/Projects/pluginsVim/'
let s:myPlugins = {
			\	'breaktime'     : '',
			\	'gulp-vim'      : '',
			\	'imagePreview'  : "{'on': '<Plug>(image-preview)'}",
			\	'lazyList'      : '',
			\	'unite-cmus'    : '',
			\	'vBox'          : '',
			\	'vCoolor'       : '',
			\	'vPreview'      : '',
			\	'vt'            : '',
			\	'yowish'        : '',
			\	'zeavim'        : "{'on': [
			\		'Zeavim', 'Docset', '<Plug>Zeavim', '<Plug>ZVVisSelection',
			\		'<Plug>ZVKeyDocset', '<Plug>ZVMotion'
			\	]}"
			\ }
" Signs for checkers  {{{1
let g:checker = {
			\	'error_sign'   : '⨉',
			\	'warning_sign' : '⬥',
			\	'success_sign' : ' ',
			\	'error_group'  : 'Error',
			\	'warning_group': 'Function',
			\ }
" Functions {{{1
function! s:MyPlugs() abort " {{{2
	let l:pn = keys(s:myPlugins)
	let l:pl = values(s:myPlugins)
	for l:i in range(0, len(l:pn) - 1)
		let l:opt = (!empty(l:pl[l:i]) ? ', ' . l:pl[l:i] : '')
		exec printf("Plug '%s'%s", expand(s:myPluginsDir) . l:pn[l:i], l:opt)
	endfor
endfunction
function! s:PlugInOs(link, param, os) abort " {{{2
	if has(a:os)
		let l:opt = (!empty(a:param) ? ', ' . a:param : '')	
		exe printf("Plug '%s'%s", a:link, l:opt)
	endif
endfunction
" 2}}}
" 1}}}

" ========== VIM-PLUG ==============================================

" Initialization {{{1
call plug#begin(g:vimDir . '/plugs')
" Plugins {{{1
" Syntaxes {{{2
Plug 'digitaltoad/vim-pug'
Plug 'kchmck/vim-coffee-script'
Plug 'othree/html5.vim'
Plug 'rhysd/vim-gfm-syntax'
Plug 'stephpy/vim-yaml'
Plug 'tbastos/vim-lua'
Plug 'tpope/vim-haml'
" Css {{{2
Plug 'othree/csscomplete.vim', {'for': 'css'}
" PHP {{{2
Plug 'StanAngeloff/php.vim'
Plug '2072/PHP-Indenting-for-VIm'     , {'for': 'php'}
Plug 'shawncplus/phpcomplete.vim'     , {'for': 'php'}
Plug 'sumpygump/php-documentor-vim'   , {'for': 'php'}
" JavaScript {{{2
Plug 'heavenshell/vim-jsdoc'
Plug 'marijnh/tern_for_vim', {'do': 'npm install'}
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'pangloss/vim-javascript'
" Python {{{2
Plug 'davidhalter/jedi-vim', {'do': 'git submodule update --init', 'for': 'python'}
Plug 'vim-python/python-syntax'
" Web development {{{2
Plug 'alvan/vim-closetag'    , {'for': ['html', 'php', 'xml']}
Plug 'chrisbra/Colorizer'    , {'on': 'ColorToggle'}
Plug 'mattn/emmet-vim'
" Git {{{2
Plug 'airblade/vim-gitgutter'
Plug 'cohama/agit.vim', {'on': ['Agit', 'AgitFile']}
Plug 'tpope/vim-fugitive'
" (( ultisnips )) {{{2
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" Fuzzy finder {{{2
Plug 'Shougo/denite.nvim'
			\| Plug 'Shougo/neomru.vim'
			\| Plug 'Shougo/neoyank.vim'
" (( textobj-user )) {{{2
Plug 'kana/vim-textobj-user'
			\| Plug 'glts/vim-textobj-comment'
			\| Plug 'kana/vim-textobj-fold'
			\| Plug 'kana/vim-textobj-function'
			\| Plug 'bps/vim-textobj-python'                 , {'for': 'python'}
			\| Plug 'kentaro/vim-textobj-function-php'       , {'for': 'php'}
			\| Plug 'thinca/vim-textobj-function-javascript' , {'for': 'javascript'}
" Edition & moving {{{2
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'machakann/vim-sandwich'
Plug 'thinca/vim-visualstar'
Plug 'Raimondi/delimitMate'
Plug 'tommcdo/vim-exchange'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
" Misc {{{2
call s:PlugInOs('tpope/vim-rvm'  , "{'on': 'Rvm'}" , 'unix')
Plug 'Chiel92/vim-autoformat'    , {'on': 'Autoformat'}
Plug 'iwataka/airnote.vim'       , {'on': ['Note', 'NoteDelete']}
Plug 'junegunn/vader.vim'        , {'on': 'Vader', 'for': 'vader'}
Plug 'junegunn/vim-emoji'        , {'for': ['markdown', 'gitcommit']}
Plug 'jwhitley/vim-matchit'
Plug 'kana/vim-tabpagecd'
Plug 'lifepillar/vim-mucomplete'
Plug 'mbbill/undotree'           , {'on': 'UndotreeToggle'}
Plug 'scrooloose/nerdtree'       , {'on': 'NERDTreeToggle'}
Plug 'w0rp/ale'
" Interface {{{2
Plug 'itchyny/vim-parenmatch'
Plug 'machakann/vim-highlightedyank', {'on': '<Plug>(highlightedyank)'}
Plug 'troydm/zoomwintab.vim'        , {'on': ['ZoomWinTabToggle', 'ZoomWinTabIn', 'ZoomWinTab']}
Plug 'Yggdroot/indentLine'
" My Plugins {{{2
if !s:labMode
	" Plug 'KabbAmine/gulp-vim'
	Plug 'KabbAmine/lazyList.vim'
	" Plug 'KabbAmine/unite-cmus'
	Plug 'KabbAmine/vBox.vim'
	Plug 'KabbAmine/vCoolor.vim'
	Plug 'KabbAmine/vullscreen.vim'
	Plug 'KabbAmine/yowish.vim'
	Plug 'KabbAmine/zeavim.vim', {'on': [
				\	'Zeavim', 'Docset', '<Plug>Zeavim', '<Plug>ZVVisSelection',
				\	'<Plug>ZVKeyDocset', '<Plug>ZVMotion'
				\ ]}
else
	call s:MyPlugs()
endif
" End {{{1
call plug#end()
" 1}}}

" ========== MISC  ===========================================

" Colors {{{1
let g:yowish = {
			\	'term_italic' : 0,
			\	'colors': {
			\		'background'       : ['#2f343f', 'none'],
			\		'backgroundDark'   : ['#191d27', '16'],
			\		'backgroundLight'  : ['#464b5b', '59'],
			\		'blue'             : ['#5295e2', '68'],
			\		'comment'          : ['#5b6176', '242'],
			\		'lightBlue'        : ['#e39f52', '179'],
			\		'lightYellow'      : ['#80aee3', '110'],
			\		'yellow'           : ['#5295e2', '68'],
			\	}
			\ }
colo yowish
hi! link TabLineSel Search
hi CursorLine ctermbg=none ctermfg=none cterm=bold
" Manually execute the ColorScheme event (Useful for some plugins)
silent doautocmd ColorScheme
" }}}

" =========== PLUGINS CONFIGS =======================
" >>> (( closetag )) {{{1
let g:closetag_filenames = '*.html,*.xml,*.php'
" >>> (( NERDTree )) {{{1
nnoremap <silent> ,N :NERDTreeToggle<CR>
" Close NERTree otherwise delete buffer
" (The delete buffer is already mapped in config/minimal.vim)
nnoremap <silent> <S-q> :execute (&ft !=# 'nerdtree' ? 'bw' : 'NERDTreeClose')<CR>
let NERDTreeBookmarksFile = g:hasWin ?
			\ 'C:\Users\k-bag\vimfiles\misc\NERDTreeBookmarks' :
			\ '/home/k-bag/.vim/misc/NERDTreeBookmarks'
let NERDTreeIgnore = ['\~$', '\.class$']
" Single-clic for folder nodes and double for files.
let NERDTreeMouseMode = 2
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeCaseSensitiveSort = 1
let NERDTreeDirArrows = 1
let NERDTreeHijackNetrw = 1
let NERDTreeMinimalUI = 1
let NERDTreeChDirMode = 2
let NERDTreeCascadeSingleChildDir = 0
let NERDTreeCascadeOpenSingleChildDir = 0
" Mappings
let NERDTreeMapOpenSplit = 's'
let NERDTreeMapOpenVSplit = 'v'
augroup NerdTree
	autocmd!
	autocmd FileType nerdtree setlocal nolist
augroup END
" >>> (( python-syntax )) {{{1
let python_highlight_all = 1
" >>> (( ale )) {{{1
" Disabled by default
let g:ale_enabled = 0
nnoremap <silent> ,E :lopen<CR>:wincmd p<CR>
nmap <silent> ]e <Plug>(ale_previous_wrap)
nmap <silent> [e <Plug>(ale_next_wrap)
nmap <silent> <F8> :ALEToggle<CR>
let g:ale_lint_on_enter = 0
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
let g:ale_sign_error = g:checker.error_sign
let g:ale_sign_warning = g:checker.warning_sign
let g:ale_echo_msg_format = '[%linter%] [%severity%] %s'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
exe 'hi! link ALEErrorSign ' . g:checker.error_group
exe 'hi! link ALEWarningSign ' . g:checker.warning_group
" Specific to file types and are here for reference
let g:ale_linters = {
			\	'c'              : ['gcc'],
			\	'coffee'         : ['coffee', 'coffeelint'],
			\	'css'            : ['csslint'],
			\	'html'           : ['htmlhint', 'tidy'],
			\	'javascript'     : ['eslint'],
			\	'json'           : ['jsonlint'],
			\	'markdown'       : ['mdl'],
			\	'php'            : ['php'],
			\	'python'         : ['flake8'],
			\	'scss'           : ['sasslint'],
			\	'sh'             : ['shellcheck', 'shell'],
			\	'vim'            : ['vint'],
			\	'yaml'           : ['yamllint'],
			\ }
let g:ale_html_tidy_executable = 'tidy5'
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_vim_vint_show_style_issues = 0
" >>> (( emmet )) {{{1
" Enable emmet for specific files.
let g:user_emmet_install_global = 0
augroup emmet
	autocmd!
	autocmd FileType html,scss,css,pug EmmetInstall
	autocmd FileType html,scss,css,pug imap <buffer> jha <plug>(emmet-anchorize-url)
	autocmd FileType html,scss,css,pug imap <buffer> jhh <plug>(emmet-expand-abbr)
	autocmd FileType html,scss,css,pug imap <buffer> jhn <plug>(emmet-move-next)
	autocmd FileType html,scss,css,pug imap <buffer> jhp <plug>(emmet-move-prev)
augroup END
" In INSERT & VISUAL modes only.
let g:user_emmet_mode='iv'
let g:emmet_html5 = 1
" >>> (( undotree )) {{{1
nnoremap <silent> ,U :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 'botright'
" >>> (( delimitmate )) {{{1
imap <S-space> <Plug>delimitMateS-Tab
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1
let delimitMate_matchpairs = '(:),[:],{:}'
" >>> (( javascript-libraries-syntax )) {{{1
" let g:used_javascript_libs = 'jquery'
" >>> (( ultisnips )) {{{1
nnoremap <C-F2> :UltiSnipsEdit<CR>
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
let g:UltiSnipsEditSplit = 'vertical'
" Personal snippets folder.
let g:UltiSnipsSnippetsDir = g:vimDir . '/misc/ultisnips'
let g:UltiSnipsSnippetDirectories = ['UltiSnips', g:vimDir . '/misc/ultisnips']
" >>> (( gitgutter )) {{{1
let g:gitgutter_map_keys = 0
let g:gitgutter_sign_added = '❙'
let g:gitgutter_sign_modified = '❙'
let g:gitgutter_sign_removed = '❙'
let g:gitgutter_sign_modified_removed = '❙'
nmap [c <Plug>GitGutterPrevHunk
nmap ]c <Plug>GitGutterNextHunk
command! GP :GitGutterPreviewHunk
if g:hasWin | let g:gitgutter_enabled = 0 | endif
" >>> (( vim-plug )) {{{1
let g:plug_threads = 10
hi! link PlugDeleted Conceal
" >>> (( jedi-vim )) {{{1
let g:jedi#completions_command = ''
let g:jedi#completions_enabled = 1
let g:jedi#smart_auto_mappings = 0
let g:jedi#auto_vim_configuration = 0
" Keybindings
let g:jedi#goto_command = 'gd'
let g:jedi#documentation_command = ''
let g:jedi#usages_command = ''
let g:jedi#goto_assignments_command= ''
let g:jedi#show_call_signatures = 2
" Don't use, buggy as hell
let g:jedi#rename_command = ''
" >>> (( autoformat )) {{{1
let g:formatters_html = ['htmlbeautify']
let g:formatdef_htmlbeautify = '"html-beautify --indent-size 2 --indent-inner-html true  --preserve-newlines -f - "'
" let g:autoformat_verbosemode = 1
" Make =ie autoformat for some ft
augroup Autoformat
	autocmd!
	autocmd Filetype python,html,json,css,javascript,scss nnoremap <buffer> =ie :Autoformat<CR>
augroup END
" >>> (( colorizer )) {{{1
 let g:colorizer_colornames = 0
" >>> (( php-documentor )) {{{1
augroup PhpDoc
	autocmd!
	autocmd Filetype php nnoremap <buffer> <silent> <C-d> :call PhpDoc()<CR>
	autocmd Filetype php inoremap <buffer> <silent> <C-d> <C-o>:call PhpDoc()<CR>
	autocmd Filetype php vnoremap <buffer> <silent> <C-d> :call PhpDocRange()<CR>
augroup END
let g:pdv_cfg_ClassTags = []
" >>> (( vim-lion )) {{{1
let g:lion_create_maps = 1
let g:lion_map_right = '<CR>'
let g:lion_map_left = ''
" >>> (( fugitive )) {{{1
" Split, vsplit & tab
augroup FugitiveMaps
	autocmd!
	autocmd FileType gitcommit nnoremap <silent> <buffer> <C-s> :norm o<CR>
	autocmd FileType gitcommit nnoremap <silent> <buffer> <C-v> :norm S<CR>
	autocmd FileType gitcommit nnoremap <silent> <buffer> <C-t> :norm O<CR>
augroup END
" Aliases
cabbrev Ga Git add
cabbrev Gb Git branch
cabbrev Gch Git checkout
cabbrev Gco Gcommit
cabbrev Gl Git log --oneline
cabbrev Gm Gmerge
cabbrev Gs Gstatus
cabbrev Gst Git stash
cabbrev Gt Git tag
" >>> (( vim-commentary )) {{{1
augroup Commentary
	autocmd!
	autocmd FileType vader,cmusrc setlocal commentstring=#\ %s
	autocmd FileType xdefaults setlocal commentstring=!\ %s
augroup END
" >>> (( agit )) {{{1
let g:agit_no_default_mappings = 1
augroup Agit
	autocmd!
	autocmd Filetype agit,agit_stat,agit_diff nmap <buffer> ch <Plug>(agit-git-checkout)
	autocmd Filetype agit,agit_stat,agit_diff nmap <buffer> P <Plug>(agit-print-commitmsg)
	autocmd Filetype agit,agit_stat,agit_diff nmap <buffer> q <Plug>(agit-exit)
	autocmd Filetype agit,agit_stat,agit_diff nmap <buffer> R <Plug>(agit-reload)
	autocmd Filetype agit,agit_stat nmap <buffer> D <Plug>(agit-diff)
	autocmd Filetype agit,agit_stat nmap <buffer> <C-n> <Plug>(agit-scrolldown-diff)
	autocmd Filetype agit,agit_stat nmap <buffer> <C-p> <Plug>(agit-scrollup-diff)
	autocmd Filetype agit,agit_stat nmap <buffer> <C-n> <Plug>(agit-scrolldown-diff)
	autocmd Filetype agit,agit_stat nmap <buffer> <C-p> <Plug>(agit-scrollup-diff)
augroup END
" >>> (( vim-rvm )) {{{1
if g:hasUnix && executable('rvm')
	augroup Rvm
		autocmd!
		autocmd GUIEnter * Rvm
	augroup END
endif
" >>> (( vim-highlightedyank )) {{{1
let g:highlightedyank_highlight_duration = 200
map <silent> y <Plug>(highlightedyank)
map <silent> Y <Plug>(highlightedyank)$
" The following mappings are already defined in /config/minimal.vim
nmap <silent> cy "+<Plug>(highlightedyank)
nmap <silent> cY "+<Plug>(highlightedyank)$
" >>> (( vim-sandwich )) {{{1
call operator#sandwich#set('all', 'all', 'cursor', 'keep')
call operator#sandwich#set('all', 'all', 'hi_duration', 50)
vmap v ab
" Allow using . with the keep cursor option enabled
nmap . <Plug>(operator-sandwich-dot)
hi link OperatorSandwichStuff StatusLine
" >>> (( indentLine )) {{{1
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_fileTypeExclude = ['json', 'vim', 'javascript', 'c', 'sh', 'php']
" >>> (( vim-jsdoc )) {{{1
augroup JsDoc
	autocmd!
	autocmd Filetype javascript nnoremap <buffer> <silent> <C-d> :JsDoc<CR>
	autocmd Filetype javascript inoremap <buffer> <silent> <C-d> <C-o>:JsDoc<CR>
augroup END
" Check doc when needed!!!
" >>> (( tern_for_vim )) {{{1
let tern_show_signature_in_pum = 1
augroup Tern
	autocmd!
	autocmd Filetype javascript nmap <buffer> gd :TernDef<CR>
augroup END
" >>> (( vim-parenmatch )) {{{1
let g:parenmatch_highlight = 0
hi! link ParenMatch WarningMsg
" >>> (( vim-emoji )) {{{1
augroup Emoji
	autocmd!
	autocmd FileType markdown,gitcommit :setl completefunc=emoji#complete
augroup END
" >>> (( zoomwintab )) {{{1
nnoremap gsz :ZoomWinTabToggle<CR>
" >>> (( textobj-usr )) & its plugins {{{1
" (( vim-textobj-comment )) {{{2
let g:textobj_comment_no_default_key_mappings = 1
xmap ic <Plug>(textobj-comment-i)
omap ic <Plug>(textobj-comment-i)
xmap ac <Plug>(textobj-comment-a)
omap ac <Plug>(textobj-comment-a)
" (( vim-textobj-python )) {{{2
let g:textobj_python_no_default_key_mappings = 1
call textobj#user#map('python', {
			\	'class': {
			\		'select-a': '<buffer>aC',
			\		'select-i': '<buffer>iC',
			\	}
			\ })
" >>> (( vim-gutentags )) {{{1
let g:gutentags_ctags_executable = 'ctags-exuberant'
let g:gutentags_cache_dir = g:vimDir . '/misc/tags/'
let g:gutentags_define_advanced_commands = 1
" >>> (( vim-visualstar )) {{{1
noremap <Plug>N N
map * <Plug>(visualstar-*)<Plug>N
map # <Plug>(visualstar-#)<Plug>N
" >>> (( Denite )) {{{1
if executable('rg')
	call denite#custom#var('file_rec', 'command',
				\ ['rg', '--files', '--hidden', '--glob', '!.git/'])
elseif executable('ag')
	call denite#custom#var('file_rec', 'command',
				\ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
endif
call denite#custom#var('buffer', 'date_format', '')
call denite#custom#var('outline', 'options', ['-u'])
call denite#custom#option('_', {
			\	'highlight_matched_char' : 'WarningMsg',
			\	'highlight_matched_range': 'None',
			\	'highlight_mode_normal'  : 'CursorLine',
			\	'prompt'                 : '>',
			\	'smartcase'              : v:true,
			\	'statusline'             : v:false,
			\	'winheight'              : 15,
			\ })
hi! link deniteSource_buffer None
hi! link deniteSource_Name Question
hi! link deniteSource_buffer_Info None
hi! link deniteSource_buffer_Prefix None
hi! link deniteSelectedLine ModeMsg
" Mappings
nnoremap <silent> ,f :Denite -buffer-name=Files file_rec<CR>
nnoremap <silent> ,b :Denite -buffer-name=Buffers -winheight=10 buffer<CR>
nnoremap <silent> ,r :Denite -buffer-name=MRU file_mru<CR>
nnoremap <silent> ,d :Denite -buffer-name=Directories -default-action=cd directory_rec<CR>
nnoremap <silent> ,c :Denite -buffer-name=Commands command<CR>
nnoremap <silent> ,h :Denite -buffer-name=Help help<CR>
nnoremap <silent> ,,f :Denite -buffer-name=Outline outline<CR>
nnoremap <silent> ,T :Denite -buffer-name=OutlineT -no-statusline -split=vertical
			\ -mode=normal -no-empty -winwidth=40 outline<CR>
nnoremap <silent> ,y :Denite -buffer-name=Yanks neoyank<CR>
inoremap <silent> <A-y> <Esc>:Denite -buffer-name=Yanks
			\ -default-action=append neoyank<CR>
" ***** Insert mode
call denite#custom#map('insert', '<C-d>',
			\ '<denite:do_action:delete>', 'noremap')
call denite#custom#map('insert', '<C-n>',
			\ '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-p>',
			\ '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-s>',
			\ '<denite:do_action:split>', 'noremap')
call denite#custom#map('insert', '<C-a>',
			\ '<denite:toggle_select_all>', 'noremap')
call denite#custom#map('insert', '<C-space>',
			\ '<denite:toggle_select_down>', 'noremap')
call denite#custom#map('insert', '<C-t>',
			\ '<denite:do_action:tabopen>', 'noremap')
call denite#custom#map('insert', '<C-v>',
			\ '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map('insert', 'jk', '<denite:quit>', 'noremap')
" ***** Normal mode
call denite#custom#map('normal', 's', '<denite:do_action:split>', 'noremap')
call denite#custom#map('normal', 'v', '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map('normal', 'p', '<denite:do_action:preview>', 'noremap')
call denite#custom#map('normal', '<C-h>', '<denite:wincmd:h>', 'noremap')
call denite#custom#map('normal', '<C-j>', '<denite:wincmd:j>', 'noremap')
call denite#custom#map('normal', '<C-k>', '<denite:wincmd:k>', 'noremap')
call denite#custom#map('normal', '<C-l>', '<denite:wincmd:l>', 'noremap')
" >>> (( mucomplete )) {{{1
set completeopt=menuone,noselect,noinsert
set shortmess+=c   " Shut off completion messages
let g:mucomplete#no_mappings = 1
let g:mucomplete#cycle_with_trigger = 1
let g:mucomplete#can_complete = {}
let g:mucomplete#can_complete.default = {
			\   'omni': { t -> strlen(&l:omnifunc) > 0
			\             &&  (g:mucomplete_with_key || t =~# '\m\k\k$')},
			\ }
let g:mucomplete#can_complete.markdown = {'user': {t -> t =~# ':.*[^:]$'}}
let g:mucomplete#can_complete.gitcommit = g:mucomplete#can_complete.markdown
let g:mucomplete#chains = {
			\	'default'    : ['path', 'omni', 'ulti', 'keyn', 'dict', 'uspl'],
			\	'gitcommit'  : ['user', 'keyn'],
			\	'markdown'   : ['path', 'user', 'keyn', 'ulti'],
			\	'vim'        : ['ulti', 'path', 'cmd', 'keyn'],
			\ }
nnoremap <silent> <F7> :MUcompleteAutoToggle<CR>
inoremap <expr> <c-e> mucomplete#popup_exit("\<c-e>")
inoremap <expr> <cr> mucomplete#popup_exit("\<cr>")
imap <Tab> <plug>(MUcompleteFwd)<C-p>
imap <S-Tab> <plug>(MUcompleteBwd)<C-p>
" >>> (( airnote )) {{{1
let g:airnote_path = expand(g:vimDir . '/misc/memos')
let g:airnote_suffix = 'md'
let g:airnote_date_format = '%d %b %Y %X'
let g:airnote_open_prompt = 'Open note > '
let g:airnote_delete_prompt = 'Delete note > '
let g:airnote_default_open_cmd = 'vsplit'
" Auto-generate the date when the file is saved
augroup Airnote
	autocmd!
	execute printf(
				\ 'autocmd BufWrite %s/*.%s :call setline(1,  "> " . strftime(g:airnote_date_format))',
				\ g:airnote_path,
				\ g:airnote_suffix
				\ )
augroup END
" >>> (( zeavim )) {{{1
nmap gzz <Plug>Zeavim
vmap gzz <Plug>ZVVisSelection
nmap <leader>z <Plug>ZVKeyDocset
nmap gZ <Plug>ZVKeyDocset<CR>
nmap gz <Plug>ZVMotion
let g:zv_file_types = {
			\	'help'                 : 'vim',
			\	'.htaccess'            : 'apache http server',
			\	'javascript'           : 'javascript,nodejs',
			\	'python'               : 'python 3',
			\	'\v^(G|g)ulpfile\.js'  : 'gulp,javascript,nodejs',
			\ }
let g:zv_zeal_args = g:hasUnix ? '--style=gtk+' : ''
let g:zv_docsets_dir = g:hasUnix ?
			\ '~/Important!/docsets_Zeal/' : 'Z:/k-bag/Important!/docsets_Zeal/'
" >>> (( vcoolor )) {{{1
let g:vcoolor_lowercase = 1
let g:vcoolor_disable_mappings = 1
let g:vcoolor_map = '<A-c>'
let g:vcool_ins_rgb_map = '<A-r>'
" >>> (( gulp-vim )) {{{1
let g:gv_rvm_hack = 1
" >>> (( lazyList )) {{{1
let g:lazylist_omap = 'ii'
nnoremap gli :LazyList ''<Left>
vnoremap gli :LazyList ''<Left>
let g:lazylist_maps = [
			\	'gl',
			\	{
			\		'l'  : '',
			\		'*'  : '* ',
			\		'-'   : '- ',
			\		'+'   : '+ ',
			\		't'   : '- [ ] ',
			\		'2'  : '%2%. ',
			\		'3'  : '%3%. ',
			\		'.1' : '1.%1%. ',
			\		'.2' : '2.%1%. ',
			\		'.3' : '3.%1%. ',
			\		'##': '# ',
			\		'#2': '## ',
			\		'#3': '### ',
			\	}
			\ ]
" >>> (( vBox )) {{{1
nnoremap <S-F2> :VBEdit 
let g:vbox = {
			\	'dir': g:vimDir . '/misc/templates',
			\	'empty_buffer_only': 0
			\ }
let g:vbox.variables = {
			\	'%LICENSE%'  : 'MIT',
			\	'%MAIL%'     : 'amine.kabb@gmail.com',
			\	'%NAME%'     : 'Kabbaj Amine',
			\	'%PROJECT%'  : 'f=fnamemodify(getcwd(), ":t")',
			\	'%REPO%'     : 'https://github.com/KabbAmine/',
			\	'%USERNAME%' : 'KabbAmine',
			\	'%YEAR%'     : 'f=strftime("%Y")',
			\ }
" For ALE
call extend(g:vbox.variables, {
			\	'%TYPE%'     : 'f=split(expand("%:p:h"), "/")[-1]',
			\ })
augroup VBoxAuto
	autocmd!
	" For vim plugins
	exe 'autocmd BufNewFile ' . s:myPluginsDir . '*/README.md :VBTemplate README.md-vim'
	exe 'autocmd BufNewFile ' . s:myPluginsDir . '*/**/*.vim :VBTemplate vim-plugin'
	exe 'autocmd BufNewFile ' . s:myPluginsDir . '*/doc/*.txt :VBTemplate vim-doc'
	" Misc
	autocmd BufNewFile LICENSE                          :VBTemplate license-MIT
	autocmd BufNewFile CHANGELOG.md,.tern-project       :VBTemplate
	autocmd BufNewFile *.py,*.sh,*.php,*.html,*.js,*.c  :VBTemplate
augroup END
" >>> (( imagePreview )) {{{1
nmap gi <Plug>(image-preview)
let g:image_preview = {
			\	'_': {
			\		'prg'  : 'feh',
			\		'args' : '--scale-down --no-menus --quiet --magick-timeout 1',
			\	},
			\	'gif': {
			\		'prg'  : 'exo-open',
			\		'args' : '',
			\	},
			\ }
" 1}}}


" vim:ft=vim:fdm=marker:fmr={{{,}}}:
