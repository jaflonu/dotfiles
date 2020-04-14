" ===============================================================
" Jorge's Vimrc Settings
" Mantainer: Jorge A. Flores <jorge.nunez@cimat.mx>
" Release: 19/Mar/2020
"
" ===============================================================


""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""

" Basic initializations
execute pathogen#infect()
set nocompatible
set nowrap
set encoding=utf-8
syntax on
filetype plugin indent on
set backspace=indent,eol,start
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set autoread
set splitbelow
set splitright

" Search preferences
set gdefault
set hlsearch
set incsearch

" Screen splits navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Code folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" Save all opened buffers
try
	wall
catch /^Vim\%((\a\+)\)\=:E141
endtry

" Syntax style
colorscheme space-vim-dark
set termguicolors
hi Comment cterm=italic
hi Normal ctermbg=NONE guibg=NONE
hi LineNr ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
set showmatch
set scrolloff=4

" Current line highlighting
highlight clear CursorLine
hi CursorLine term=bold cterm=bold
set cursorline

" System fonts
if has("linux")
	set gfn=IBM\ Plex\ Mono\ 14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitsream\ Vera\ Sans\ Mono\ 11
elseif has("gui_gtk2")
	set gfn=IBM\ Plex\ Mono\ 14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitsream\ Vera\ Sans\ Mono\ 11
elseif has("unix")
	set gfn=Monospace\ 11
endif

" Scrollbars disablement
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" Leader command setup
let mapleader=","
let g:mapleader=","
nnoremap <leader><Esc> :q!<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>z :wq<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>s :%s/
noremap <leader>r :!%:p<cr>
nnoremap <leader>c :%s/\s\+$//<cr>:let @/=''<cr>
nnoremap <leader>v :split<cr>

" System clipboard utilities
set clipboard=unnamedplus
set undolevels=1000
set history=1000
nnoremap d "_d
vnoremap d "_d

" No redraw while executing macros
set lazyredraw

" Bash-like keys for the command mode
cnoremap <c-a> <Home>
cnoremap <c-e> <End>
cnoremap <c-k> <c-u>
cnoremap <c-p> <up>
cnoremap <c-n> <down>

" Cursor position restoring when reopening files
autocmd BufReadPost *
    \ if &filetype != "gitcommit" && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" Quickfix
nnoremap <leader>i :call Quickfix()<cr>
let g:quickfix_is_open = 0
function! Quickfix()
		if g:quickfix_is_open
				cclose
				let g:quickfix_is_open = 0
				execute g:quickfix_return_to_window . "wincmd w"
		else
				let g:quickfix_return_to_window = winnr()
				copen
				let g:quickfix_is_open = 1
		endif
endfunction

" Conflict markers
match ErrorMsg '\v^[<\|=|>]{7}([^=].+)?$'

" Uppercase mapping
inoremap <c-u> <esc>viwUea
nnoremap <c-u> viwue

" Persistent undo
try
		set undodir=~/.vim_runtime/temp_dirs/undodir
		set undofile
catch
endtry

" Paragraph smart-quoting
vnoremap ' :s/'/’/<cr>

" Whitespace flagging
autocmd BufNewFile,BufRead *.pyw, *.c, *.h, *.jl match BadWhitespace /\s\+$/

" Headings for markup languages
nnoremap <leader>1 yyPVr=jyypVr=
nnoremap <leader>2 yyPVr*jyypVr*
nnoremap <leader>3 yypVr=
nnoremap <leader>4 yypVr-
nnoremap <leader>5 yypVr^
nnoremap <leader>6 yypVr"

" Markdown formatting
autocmd BufNewFile,BufRead *.md set wrap linebreak nolist
autocmd BufNewFile,BufRead *.md setlocal display+=lastline
autocmd BufNewFile,BufRead *.md set formatoptions+=1
autocmd BufNewFile,BufRead *.md set breakindent 
autocmd BufNewFile,BufRead *.md onoremap <silent> j gj
autocmd BufNewFile,BufRead *.md onoremap <silent> k gk
autocmd BufNewFile,BufRead *.md vnoremap <silent> j gj
autocmd BufNewFile,BufRead *.md vnoremap <silent> k gk
autocmd BufNewFile,BufRead *.md nnoremap <silent> j gj
autocmd BufNewFile,BufRead *.md nnoremap <silent> k gk
autocmd BufNewFile,BufRead *.md nnoremap <silent> 0 g0
autocmd BufNewFile,BufRead *.md nnoremap <silent> $ g$
autocmd BufNewFile,BufRead *.md nnoremap <silent> <Up> gk
autocmd BufNewFile,BufRead *.md nnoremap <silent> <Down> gj
autocmd BufNewFile,BufRead *.md inoremap <silent> <Up> gk
autocmd BufNewFile,BufRead *.md inoremap <silent> <Down> gj
autocmd BufNewFile,BufRead *.md inoremap <silent> <Up> <c-o>gk
autocmd BufNewFile,BufRead *.md inoremap <silent> <Down> <c-o>gj
autocmd BufNewFile,BufRead *.md inoremap <silent> <Home> <c-o>g<Home>
autocmd BufNewFile,BufRead *.md inoremap <silent> <End> <c-o>g<End>

" LaTeX formatting
autocmd BufNewFile,BufRead *.tex set wrap linebreak nolist
autocmd BufNewFile,BufRead *.tex setlocal display+=lastline
autocmd BufNewFile,BufRead *.tex set formatoptions+=1
autocmd BufNewFile,BufRead *.tex set breakindent 
autocmd BufNewFile,BufRead *.tex onoremap <silent> j gj
autocmd BufNewFile,BufRead *.tex onoremap <silent> k gk
autocmd BufNewFile,BufRead *.tex vnoremap <silent> j gj
autocmd BufNewFile,BufRead *.tex vnoremap <silent> k gk
autocmd BufNewFile,BufRead *.tex nnoremap <silent> j gj
autocmd BufNewFile,BufRead *.tex nnoremap <silent> k gk
autocmd BufNewFile,BufRead *.tex nnoremap <silent> 0 g0
autocmd BufNewFile,BufRead *.tex nnoremap <silent> $ g$
autocmd BufNewFile,BufRead *.tex nnoremap <silent> <Up> gk
autocmd BufNewFile,BufRead *.tex nnoremap <silent> <Down> gj
autocmd BufNewFile,BufRead *.tex inoremap <silent> <Up> gk
autocmd BufNewFile,BufRead *.tex inoremap <silent> <Down> gj
autocmd BufNewFile,BufRead *.tex inoremap <silent> <Up> <c-o>gk
autocmd BufNewFile,BufRead *.tex inoremap <silent> <Down> <c-o>gj
autocmd BufNewFile,BufRead *.tex inoremap <silent> <Home> <c-o>g<Home>
autocmd BufNewFile,BufRead *.tex inoremap <silent> <End> <c-o>g<End>

" Python formatting
autocmd filetype python setlocal textwidth=78
autocmd filetype python match ErrorMsg '\%>120v.\+'
autocmd filetype python setlocal formatoptions-=t

" HTML/CSS/JavaScript formatting
autocmd BufNewFile,BufRead *.html,*.css,*.js set tabstop=2
autocmd BufNewFile,BufRead *.html,*.css,*.js set softtabstop=2
autocmd BufNewFile,BufRead *.html,*.css,*.js set shiftwidth=2


""""""""""""""""""""""""""""""""""""""""
" => CtrlP
""""""""""""""""""""""""""""""""""""""""

" Maximum fuzzy search lines to show
let g:crtlp_max_height = 50

" Folders and files to ignore
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git'

" Search the whole git project directory
let g:ctrlp_working_path_mode = 'ar'

" No maximum file limit
let g:ctrlp_max_files = 0

" Show hidden files
let g:ctrlp_show_hidden = 1

" Toggle key enablement
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
nnoremap <leader>b :CtrlPBuffer<cr>


""""""""""""""""""""""""""""""""""""""""
" => NERDCommenter
""""""""""""""""""""""""""""""""""""""""

" Add a whitespace by default after comment
let g:NERDSpaceDelims = 1

" Compact syntax for multi-line comments
let g:NERDCompactSexyComs = 1

" Comment flush-left alignment instead of indentation
let g:NERDDefaultAlign = 'left'

" Custom delimiters format
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow block-commenting empty lines
let g:NERDCommentEmptyLines = 1

" Trimming of trailing whitespace enablement when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Toggle enablement to check if all selected lines are commented 
let g:NERDToggleCheckAllLines = 1


""""""""""""""""""""""""""""""""""""""""
" => NERDTree
""""""""""""""""""""""""""""""""""""""""

" Defaults
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1

" Open it once Vim starts
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Do not open it when opening a saved session
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif

" Open it when Vim starts up opening a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd'.argv()[0] | endif

" Toggle key enablement
map <leader>f :NERDTreeToggle<cr>
nnoremap <leader>h :NERDTreeClose<cr>:NERDTreeFind<cr>
map <leader>' :split<cr>
map <leader>" :vsplit<cr>
map <leader>n :new<cr>:NERDTreeToggle<cr>
map <leader>m :vnew<cr>:NERDTreeToggle<cr>

" Exit Vim when only NERDTree buffer left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Files highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
	exec 'autocmd filetype nerdtree highlight ' . a:extension . ' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
	exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

" Ignoring files
let NERDTreeIgnore=['\.so$', '\.egg$', '\.pyc$', '\.pyo$', '\.py\$class$', '__pycache__', '\.DS_Store', '\~$']


""""""""""""""""""""""""""""""""""""""""
" => Mutiple Cursors
""""""""""""""""""""""""""""""""""""""""

" Selecting keywords with several keystrokes
nnoremap <silent> <M-j> :MultipleCursorsFind <C-R>/<cr>
vnoremap <silent> <M-j> :MultipleCursorsFind <C-R>/<cr>


""""""""""""""""""""""""""""""""""""""""
" => YouCompleteMe
""""""""""""""""""""""""""""""""""""""""

" Close the auto-complete window when it is done
let g:ycm_autoclose_preview_window_after_completion=1

" Shortcut for goto definition
map <leader>g :YcmCompleter GotoDefinitionElseDeclaration<cr>


""""""""""""""""""""""""""""""""""""""""
" => Syntastic
""""""""""""""""""""""""""""""""""""""""

" Checkers enablement 
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_loc_list_height=4

" Beautifying Python syntax
let g:flake8_show_in_gutter=0
let python_highlight_all=1

" Toggle navigation
nnoremap <leader>l :lclose<cr>
nnoremap <leader>j :lprev<cr>
nnoremap <leader>k :lnext<cr>
nnoremap <leader>o :SyntasticCheck<cr>


""""""""""""""""""""""""""""""""""""""""
" => ArgWrap
""""""""""""""""""""""""""""""""""""""""

" Toggle key enablement
nnoremap <leader>a :ArgWrap<cr>

" Comma delimiter
let g:argwrap_tail_comma=1
