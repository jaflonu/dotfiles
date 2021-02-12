"
" ~/.vimrc
"

"---- DEFAULTS ----"

" Vim settings instead of Vi
if &compatible
  set nocompatible
endif
" Backspacing in insert mode
set backspace=indent,eol,start
set history=200
" Show the cursor position
set ruler
" Show incomplete commands
set showcmd
" Display completion matches in status
set wildmenu
" Time out for key codes
set ttimeout
set ttimeoutlen=100
set display=truncate
" Show a few lines of context
set scrolloff=5
set sidescrolloff=5
" Incremental searching if timeout is possible
if has('reltime')
  set incsearch
endif
" Do not recognize octal numbers
set nrformats-=octal
" No tearoff menu entries
if has('win32')
  set guioptions-=t
endif
" Enabling visual mode for mouse
if has('mouse')
  set mouse=nvi
endif
" Switch syntax highlitghting on when terminal has colors
if &t_Co > 2
  syntax on
  let c_comment_strings=1
endif
" Keep current color settings
if !has('syntax') && !exists('g:syntax_on')
  syntax enable
endif
" Enable file type detection and last cursor position
if 1
  filetype plugin indent on
  augroup vimStartup
    au!
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif
  augroup END
endif
" Changes made between current buffer and file it was loaded from
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit
    \ | wincmd p | diffthis
endif
" Protect plugins by preventing the langmap option
if has('langmap') && exists('+langremap')
  set nolangremap
endif
" System clipboard
set clipboard=unnamed
nnoremap d "_d
vnoremap d "_d
" Sensible format
set encoding=utf-8
set complete-=i
set autoindent
set smarttab
set lazyredraw
" Rice cursor line
highlight CursorLine cterm=bold ctermbg=NONE
set cursorline
" Rice syntax
highlight Comment cterm=italic ctermbg=NONE
" Rice selection
highlight Visual cterm=bold ctermbg=Gray ctermfg=NONE
" Rice tab bar
highlight TabLineFill ctermfg=Gray ctermbg=NONE
highlight TabLine ctermfg=NONE ctermbg=Gray
" Persistent undo
try
  set undodir=~/.vim_runtime/temp_dirs/undodir
  set undofile
catch
endtry
" Set local directory
if exists('+autochdir')
  set autochdir
endif
" Latex type setting
function! LatexFormat()
  set filetype=tex
  let g:tex_flavor='latex'
  set wrap linebreak
  set breakindent
  map <silent> j gj
  map <silent> k gk
  map <silent> 0 g0
  map <silent> $ g$
  map <silent> <Up> gk
  map <silent> <Down> gj
endfunction
autocmd BufRead,BufNewFile *.tex call LatexFormat()
" Markdown format
function! MarkdownFormat()
  set wrap linebreak
  set breakindent
  map <silent> j gj
  map <silent> k gk
  map <silent> 0 g0
  map <silent> $ g$
  map <silent> <Up> gk
  map <silent> <Down> gj
endfunction
autocmd BufNewFile,BufRead *.md call MarkdownFormat()

"---- MACROS ----"

" Hard wrap lines
map Q gq
" Cut line while editing
if empty(mapcheck('<C-U>', 'i'))
  inoremap <C-U> <C-G>u<C-U>
endif
" Cut word while editing
if empty(mapcheck('<C-W>', 'i'))
  inoremap <C-W> <C-G>u<C-W>
endif
" Code folding
if empty(mapcheck('<Space>', 'n'))
  nnoremap <Space> za
endif
" Uppercase word
if empty(mapcheck('<C-B>', 'i'))
  inoremap <C-B> <Esc>viwUea
endif
" Lowercase word
if empty(mapcheck('<C-B>', 'n'))
  nnoremap <C-B> viwue
endif
" Compilation prototype
function! Compile()
  if index(['c'], &filetype) != -1
    execute 'w'
    execute '!gcc -o %:r %'
  elseif index(['cpp'], &filetype) != -1
    execute 'w'
    execute '!g++ -o %:r %'
  elseif index(['tex'], &filetype) != -1
    execute 'w'
    execute '!pdflatex %'
  else
    echom 'No compiler set for this filetype.'
  endif
endfunction
" Execution prototype
function! Order66()
  if index(['c'], &filetype) != -1
    execute 'w'
    execute '!gcc -o %:r % && ./%:r'
    execute '!./%r'
  elseif index(['cpp'], &filetype) != -1
    execute 'w'
    execute '!g++ -o %:r % && ./%:r'
  elseif index(['tex'], &filetype) != -1
    execute 'w'
  else
    echom 'No compiler set for this filetype.'
  endif
endfunction
" Leader mappings
let mapleader=","
let g:mapleader=","
nnoremap <leader><Esc> :q!<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>z :wq<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>s :%s/
nnoremap <leader><Return> :term<cr>
nnoremap <leader>o :tabe 
nnoremap <leader><S-H> :tabmove -1<cr>
nnoremap <leader><S-L> :tabmove 2<cr>
nnoremap <leader>c :call Compile()<cr>
nnoremap <leader>x :call Order66()<cr>

"---- PLUGINS ----"

" Initialize manager
call plug#begin('~/.vim/plugged')
  " Status bar
  Plug 'vim-airline/vim-airline'
  " Mappings for surroundings
  Plug 'tpope/vim-surround'
  " Comment and uncomment made simple
  Plug 'tpope/vim-commentary'
  " Latex autocompletion
  Plug 'brennier/quicktex'
call plug#end()

" Latex plain mode dictionary
let g:quicktex_tex = {
  \' ' : "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
  \'m' : '\( <+++> \)<++>',
  \'sect' : "\\section*{<+++>}\<CR><++>",
  \'subsect' : "\\subsection{<+++>}\<CR><++>",
  \'itm' : '\item ',
  \'center'  : "\\begin{center}\<CR><+++>\<CR>\\end{center}\<CR><++>",
  \'tikz' : "\\begin{tikzpicture}\<CR>\\node <+++>\<CR>\\end{tikzpicture}",
  \'node' : '\node ',
  \'emph' : '\emph{<+++>} <++>',
  \'qt'   : "``<+++>'' <++>",
  \'paren'   : "(<+++>) <++>",
  \'env' : "\<ESC>Bvedi\\begin{\<ESC>pa}\<CR><+++>\<CR>\\end{\<ESC>pa}",
  \'thm' : "\\begin{theorem}[<+++>]\<CR><++>\<CR>\\end{theorem}\<CR><++>",
  \'def' : "\\begin{definition}[<+++>]\<CR><++>\<CR>\\end{definition}\<CR><++>",
  \'cor' : "\\begin{corollary}\<CR><+++>\<CR>\\end{corollary}\<CR><++>",
  \'lem' : "\\begin{lemma}\<CR><+++>\<CR>\\end{lemma}\<CR><++>",
  \'prf' : "\\begin{proof}\<CR><+++>\<CR>\\end{proof}",
  \'xmp' : "\\begin{example}\<CR><+++>\<CR>\\end{example}",
  \'lst' : "\\begin{enumerate}\<CR>\\item <+++>\<CR>\\end{enumerate}",
  \'eq'  : "\\begin{displaymath}\<CR><+++>\<CR>\\end{displaymath}\<CR><++>",
  \'eqn' : "\\begin{equation}\\label{<+++>}\<CR><++>\<CR>\\end{equation}",
  \'agn'  : "\\begin{align*}\<CR><+++>\<CR>\\end{align*}",
  \'bn' : '\(\mathbb{N}\) ',
  \'bz' : '\(\mathbb{Z}\) ',
  \'bq' : '\(\mathbb{Q}\) ',
  \'br' : '\(\mathbb{R}\) ',
  \'bc' : '\(\mathbb{C}\) ',
  \'ba' : '\(\mathbb{A}\) ',
  \'bf' : '\(\mathbb{F}\) ',
  \'bk' : '\(\mathbb{K}\) ',
  \'fB' : '\(\mathcal{B}\) ',
  \'fL' : '\(\mathcal{L}\) ',
  \'fA' : '\(\mathcal{A}\) ',
  \'fO' : '\(\mathcal{O}\) ',
  \'fR' : '\(\mathcal{R}\) ',
  \'fN' : '\(\mathcal{N}\) ',
  \'fP' : '\(\mathcal{P}\) ',
  \'fT' : '\(\mathcal{T}\) ',
  \'fC' : '\(\mathcal{C}\) ',
  \'fM' : '\(\mathcal{M}\) ',
  \'fF' : '\(\mathcal{F}\) ',
  \'fI' : '\(\mathcal{I}\) ',
  \'fV' : '\(\mathcal{V}\) ',
  \'fS' : '\(\mathcal{S}\) ',
  \'rB' : '\(\mathfrak{b}\) ',
  \'rL' : '\(\mathfrak{L}\) ',
  \'rA' : '\(\mathfrak{a}\) ',
  \'rO' : '\(\mathfrak{o}\) ',
  \'rR' : '\(\mathfrak{R}\) ',
  \'rN' : '\(\mathfrak{n}\) ',
  \'rP' : '\(\mathfrak{p}\) ',
  \'rT' : '\(\mathfrak{T}\) ',
  \'rC' : '\(\mathfrak{c}\) ',
  \'rM' : '\(\mathfrak{m}\) ',
  \'rF' : '\(\mathfrak{f}\) ',
  \'rI' : '\(\mathfrak{i}\) ',
  \'rV' : '\(\mathfrak{v}\) ',
  \'rS' : '\(\mathfrak{S}\) ',
  \'sB' : '\(\mathscr{B}\) ',
  \'sL' : '\(\mathscr{L}\) ',
  \'sA' : '\(\mathscr{A}\) ',
  \'sO' : '\(\mathscr{O}\) ',
  \'sR' : '\(\mathscr{R}\) ',
  \'sN' : '\(\mathscr{N}\) ',
  \'sP' : '\(\mathscr{P}\) ',
  \'sT' : '\(\mathscr{T}\) ',
  \'sC' : '\(\mathscr{C}\) ',
  \'sM' : '\(\mathscr{M}\) ',
  \'sF' : '\(\mathscr{F}\) ',
  \'sI' : '\(\mathscr{I}\) ',
  \'sV' : '\(\mathscr{V}\) ',
  \'alpha'   : '\(\alpha\) ',
  \'beta'    : '\(\beta\) ',
  \'gamma'   : '\(\gamma\) ',
  \'delta'   : '\(\delta\) ',
  \'epsilon' : '\(\epsilon\) ',
  \'vareps'  : '\(\varepsilon\) ',
  \'zeta'    : '\(\zeta\) ',
  \'eta'     : '\(\eta\) ',
  \'theta'   : '\(\theta\) ',
  \'iota'    : '\(\iota\) ',
  \'kappa'   : '\(\kappa\) ',
  \'lambda'  : '\(\lambda\) ',
  \'gl'      : '\(\lambda\) ',
  \'mu'      : '\(\mu\) ',
  \'nu'      : '\(\nu\) ',
  \'xi'      : '\(\xi\) ',
  \'omega'   : '\(\omega\) ',
  \'pi'      : '\(\pi\) ',
  \'rho'     : '\(\rho\) ',
  \'sigma'   : '\(\sigma\) ',
  \'tau'     : '\(\tau\) ',
  \'upsilon' : '\(\upsilon\) ',
  \'phi'     : '\(\phi\) ',
  \'varphi'     : '\(\varphi\) ',
  \'chi'     : '\(\chi\) ',
  \'psi'     : '\(\psi\) ',
\}

" Latex math mode dictionary
let g:quicktex_math = {
  \' ' : "\<ESC>:call search('<+.*+>')\<CR>\"_c/+>/e\<CR>",
  \'bn' : '\mathbb{N} ',
  \'bz' : '\mathbb{Z} ',
  \'bq' : '\mathbb{Q} ',
  \'br' : '\mathbb{R} ',
  \'bc' : '\mathbb{C} ',
  \'ba' : '\mathbb{A} ',
  \'bf' : '\mathbb{F} ',
  \'bk' : '\mathbb{K} ',
  \'fB' : '\mathcal{B} ',
  \'fL' : '\mathcal{L} ',
  \'fA' : '\mathcal{A} ',
  \'fO' : '\mathcal{O} ',
  \'fR' : '\mathcal{R} ',
  \'fN' : '\mathcal{N} ',
  \'fP' : '\mathcal{P} ',
  \'fT' : '\mathcal{T} ',
  \'fC' : '\mathcal{C} ',
  \'fM' : '\mathcal{M} ',
  \'fF' : '\mathcal{F} ',
  \'fI' : '\mathcal{I} ',
  \'fV' : '\mathcal{V} ',
  \'fS' : '\mathcal{S} ',
  \'rB' : '\mathfrak{b} ',
  \'rL' : '\mathfrak{L} ',
  \'rA' : '\mathfrak{a} ',
  \'rO' : '\mathfrak{o} ',
  \'rR' : '\mathfrak{R} ',
  \'rN' : '\mathfrak{n} ',
  \'rP' : '\mathfrak{p} ',
  \'rT' : '\mathfrak{T} ',
  \'rC' : '\mathfrak{c} ',
  \'rM' : '\mathfrak{m} ',
  \'rF' : '\mathfrak{f} ',
  \'rI' : '\mathfrak{i} ',
  \'rV' : '\mathfrak{v} ',
  \'rG' : '\mathfrak{G} ',
  \'rS' : '\mathfrak{S} ',
  \'sB' : '\mathscr{B} ',
  \'sL' : '\mathscr{L} ',
  \'sA' : '\mathscr{A} ',
  \'sO' : '\mathscr{O} ',
  \'sR' : '\mathscr{R} ',
  \'sN' : '\mathscr{N} ',
  \'sP' : '\mathscr{P} ',
  \'sT' : '\mathscr{T} ',
  \'sC' : '\mathscr{C} ',
  \'sM' : '\mathscr{M} ',
  \'sF' : '\mathscr{F} ',
  \'sI' : '\mathscr{I} ',
  \'sV' : '\mathscr{V} ',
  \'sG' : '\mathscr{G} ',
  \'sS' : '\mathscr{S} ',
  \'alpha'   : '\alpha ',
  \'beta'    : '\beta ',
  \'gamma'   : '\gamma ',
  \'delta'   : '\delta ',
  \'epsilon' : '\epsilon ',
  \'vareps'  : '\varepsilon ',
  \'zeta'    : '\zeta ',
  \'eta'     : '\eta ',
  \'theta'   : '\theta ',
  \'iota'    : '\iota ',
  \'kappa'   : '\kappa ',
  \'lambda'  : '\lambda ',
  \'gl'      : '\lambda ',
  \'mu'      : '\mu ',
  \'nu'      : '\nu ',
  \'xi'      : '\xi ',
  \'omega'   : '\omega ',
  \'pi'      : '\pi ',
  \'rho'     : '\rho ',
  \'sigma'   : '\sigma ',
  \'tau'     : '\tau ',
  \'upsilon' : '\upsilon ',
  \'phi'     : '\phi ',
  \'varphi'  : '\varphi ',
  \'chi'     : '\chi ',
  \'psi'     : '\psi ',
  \'Alpha'   : '\Alpha ',
  \'Beta'    : '\Beta ',
  \'Gamma'   : '\Gamma ',
  \'Delta'   : '\Delta ',
  \'Epsilon' : '\Epsilon ',
  \'Zeta'    : '\Zeta ',
  \'Eta'     : '\Eta ',
  \'Theta'   : '\Theta ',
  \'Iota'    : '\Iota ',
  \'Kappa'   : '\Kappa ',
  \'Lambda'  : '\Lambda ',
  \'Mu'      : '\Mu ',
  \'Nu'      : '\Nu ',
  \'Xi'      : '\Xi ',
  \'Omega'   : '\Omega ',
  \'Pi'      : '\Pi ',
  \'Rho'     : '\Rho ',
  \'Sigma'   : '\Sigma ',
  \'Tau'     : '\Tau ',
  \'Upsilon' : '\Upsilon ',
  \'Phi'     : '\Phi ',
  \'Chi'     : '\Chi ',
  \'Psi'     : '\Psi ',
  \'text' : '\text{<+++>} <++>',
  \'sub' : "\<BS>_{<+++>} <++>",
  \'hat'  : "\<ESC>Bi\\hat{\<ESC>Els} ",
  \'bar'  : "\<ESC>Bi\\overline{\<ESC>Els} ",
  \'tild'  : "\<ESC>Bi\\tild{\<ESC>Els} ",
  \'mnm'  : "\<ESC>Bi\\mathnormal{\<ESC>Els} ",
  \'mrm'  : "\<ESC>Bi\\mathrm{\<ESC>Els} ",
  \'mit'  : "\<ESC>Bi\\mathit{\<ESC>Els} ",
  \'mbf'  : "\<ESC>Bi\\mathbf{\<ESC>Els} ",
  \'msf'  : "\<ESC>Bi\\mathsf{\<ESC>Els} ",
  \'mtt'  : "\<ESC>Bi\\mathtt{\<ESC>Els} ",
  \'vec'  : "\<ESC>Bi\\vec{\<ESC>Els} ",
  \'star'  : "\<BS>^* ",
  \'par' : '( <+++> ) <++>',
  \'paren' : '\left( <+++> \right) <++>',
  \'brack'   : '\left[ <+++> \right] <++>',
  \'angle' : '\langle <+++> \rangle <++>',
  \'ocval' : '\left( <+++> \right] <++>',
  \'coval' : '\left[ <+++> \right) <++>',
  \'brace'  : '\left\{ <+++> \right\} <++>',
  \'sb'    : '[<+++>] <++>',
  \'bra'   : '\{<+++>\} <++>',
  \'frac'  : '\frac{<+++>}{<++>} <++>',
  \'binom'  : '\binom{<+++>}{<++>} <++>',
  \'recip' : '\frac{1}{<+++>} <++>',
  \'cdot'   : '\cdot ',
  \'cdots'   : '\cdots ',
  \'mult'  : '* ',
  \'pow'   : "\<BS>^{<+++>} <++>",
  \'sq'    : "\<BS>^{2} ",
  \'inv'   : "\<BS>^{-1} ",
  \'oprod'   : '\oprod ',
  \'ominus'  : '\ominus ',
  \'times'   : '\times ',
  \'exists'  : '\exists ',
  \'nexists' : '\nexists ',
  \'forall'  : '\forall ',
  \'implies' : '\rightarrow ',
  \'Implies' : '\implies ',
  \'iff'     : '\leftrightarrow ',
  \'Iff'     : '\iff ',
  \'sbset'  : '\subset ',
  \'sbqset'  : '\subseteq ',
  \'in'    : '\in ',
  \'nin'   : '\not\in ',
  \'cup'   : '\cup ',
  \'cap'   : '\cap ',
  \'bigcup'    : '\bigcup_{<+++>} <++>',
  \'bigcap'    : '\bigcap_{<+++>} <++>',
  \'setms'  : '\setminus ',
  \'set'    : '\set{<+++>} <++>',
  \'empty' : '\emptyset ',
  \'pair'  : '(<+++>, <++>) <++>',
  \'dots'  : '\dots ',
  \'lt'      : '< ',
  \'gt'      : '> ',
  \'leq'     : '\leq ',
  \'geq'     : '\geq ',
  \'eq'      : '= ',
  \'equiv'   : '\equiv ',
  \'nl'      : '\nless ',
  \'ng'      : '\ngtr ',
  \'nleq'    : '\nleq ',
  \'ngeq'    : '\ngeq ',
  \'neq'     : '\neq ',
  \'neg'     : '\neg ',
  \'comp'    : "\<BS>^{\\mathrm{c}} ",
  \'tsp'    : "\<BS>^t ",
  \'matrix' : "\<CR>\\begin{pmatrix}\<CR><+++>\<CR>\\end{pmatrix}\<CR><++>",
  \'tree' : "\<CR>\\begin{forest}\<CR><+++>\<CR>\\end{forest}\<CR><++>",
  \'array' : "\<CR>\\begin{array}{|c c|c|}\<CR><+++>\<CR>\\end{array}\<CR><++>",
  \'vdots'  : '\vdots ',
  \'ddots'  : '\ddots ',
  \'aleph' : '\aleph ',
  \'infty' : '\infty ',
  \'toinf' : '\to\infty ',
  \'oplus'  : '\oplus ',
  \'otimes'  : '\otimes ',
  \'bigoplus'  : '\bigoplus_{<+++>} <++>',
  \'bigominus' : '\bigominus_{<+++>} <++>',
  \'int'    : '\int <+++> \mathop{d <++>} <++>',
  \'dev'    : '\frac{d}{d <+++>} <++>',
  \'lim'    : '\lim_{<+++>} <++>',
  \'sum'    : '\sum_{<+++>} <++>',
  \'prod'   : '\prod_{<+++>} <++>',
  \'limsup' : '\limsup ',
  \'liminf' : '\liminf ',
  \'sup'    : '\sup(<+++>) <++>',
  \'inf'   : '\inf(<+++>) <++>',
  \'tod'    : '\tod{<+++>} <++>',
  \'to'     : '\to ',
  \'To'     : '\To ',
  \'mto' : '\mto ',
  \'Mto' : '\Mto ',
  \'circ'   : '\circ ',
  \'of'     : "\<BS>(<+++>) <++>",
  \'sin'    : '\sin{<+++>} <++>',
  \'cos'    : '\cos{<+++>} <++>',
  \'tan'    : '\tan{<+++>} <++>',
  \'gcd'    : '\gcd(<+++> ,<++>) <++>',
  \'ln'     : '\ln{<+++>} <++>',
  \'log'    : '\log{<+++>} <++>',
  \'df'     : '<+++> : <++> \to <++>',
  \'sqrt'   : '\sqrt{<+++>} <++>',
  \'case'   : '\begin{cases} <+++> \end{cases} <++>',
  \'genr'  : '\genr{<+++>} <++>',
  \'bdry'  : '\bdry{<+++>} <++>',
  \'indic' : '\indic{<+++>} <++>',
  \'sdp'   : '\rtimes ',
  \'niso'  : '\niso ',
  \'subg'  : '\leq ',
  \'nsubg' : '\trianglelefteq ',
  \'quot'   : '/ ',
  \'mod'   : '\mod ',
  \'power' : '\powerset(<+++>) <++>',
  \'oneton' : '\oneton ',
  \'ita' : '\textit{<+++>} <++>',
  \'det' : '\operatorname{det} \left( <+++> \right) <++>',
  \'dim' : '\operatorname{dim} \left( <+++> \right) <++>',
  \'rank' : '\operatorname{rank} \left( <+++> \right) <++>',
  \'ker' : '\operatorname{ker} \left( <+++> \right) <++>',
  \'img' : '\operatorname{img} \left( <+++> \right) <++>',
  \'null' : '\operatorname{null} \left( <+++> \right) <++>',
  \'trace' : '\operatorname{tr} \left( <+++> \right) <++>',
  \'sgn' : '\operatorname{sgn} \left( <+++> \right) <++>',
  \'hom' : '\operatorname{Hom} \left( <+++> \right) <++>',
  \'end' : '\operatorname{End} \left( <+++> \right) <++>',
  \'aut' : '\operatorname{Aut} \left( <+++> \right) <++>',
  \'argmax' : '\argmax{<+++>} <++>',
  \'argmin' : '\argmin{<+++>} <++>',
  \'abs' : '\abs{<+++>} <++>',
  \'ceil' : '\ceil{<+++>} <++>',
  \'floor' : '\floor{<+++>} <++>',
  \'max' : '\max\set{ <+++> } <++>',
  \'min' : '\min\set{ <+++> \} <++>',
  \'ps'   : '+ ',
  \'ms'   : '- ',
  \'st' : ': ',
  \'vbar' : '| ',
  \'amp' : '& ',
  \'db' : ':= ',
  \'bl' : '\\',
  \'quad' : '\quad ',
  \'and' : '\land ',
  \'or' : '\lor ',
  \'cong' : '\cong ',
  \'simeq' : '\simeq ',
  \'sim' : '\sim ',
  \'poly' : 'p \left( x \right) ',
  \'qoly' : 'q \left( x \right) ',
  \'coly' : '\chi_{\vec{<+++>}} \left( x \right) <++>',
  \'moly' : '\mu_{\vec{<+++>}} \left( x \right) <++>',
\}
