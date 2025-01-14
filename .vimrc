set nocompatible
filetype off   " required by vundle

let mapleader=" "
let maplocalleader=" "

" TODO... indentation is relevant here :/ this doesn't work
"augroup vimrc
" clear all autocommands since they will be added again (if .vimrc is sourced a second time)
"autocmd!

" Profiling things to try when things slow down
" - Comment out plug#begin to disable all plugins
"   - or binary search installed plugins if that fixes it
" - :profile start, :profile func *, :profile file *, <do stuff that is slow>, :profile pause, :qa!, read profile.log file
" - Turn off syntax highlighting
"   - :syntime on, then :syntime report if that fixes it
"   - or mess with set re=1 setting to change regex engine
" - Look for expensive autocommand groups (or duplicates)
"   - :au CursorMoved
" - Use vim --startuptime <files> to profile startup time
" - if this is slow, try to debounce matchparens http://vim.wikia.com/wiki/Prevent_frequent_commands_from_slowing_things_down

" Install vim-plug if it is not there
" Note: To update vim-plug, run `:PlugUpgrade`
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" TODO for nvim
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.vim/plugged')

" TODO try:
" https://github.com/liuchengxu/vim-clap (neovim)
" https://github.com/ryanoasis/vim-devicons
"Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" https://stackoverflow.com/a/13855458/683415 make window ctrl-w commands map

Plug 'kana/vim-arpeggio' " keymap chords of simultaneously pressed keys

" Install fzf globally. Do this through vim since the fzf repo also has a basic vim wrapper
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim' " Add better bindings than the default fzf vim plugin
" TODO: try out https://github.com/pbogut/fzf-mru.vim for MRU

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and previous-history instead of down and up.
let g:fzf_history_dir = '~/.vim/fzf-history'

" Jump to the existing window if possible
let g:fzf_buffers_jump = 1

nmap <leader>f :Files<CR>
nmap <leader>s :Ag<CR>
" Ag on the word under the cursor
nnoremap <silent> <leader>k :Ag <C-R><C-W><CR>

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

Plug 'tpope/vim-markdown'

" ------ Clojure support ------
" this is shipped with modern version of vim, but use latest version anyway
Plug 'guns/vim-clojure-static'

let g:clojure_align_multiline_string = 1
let g:clojure_align_multiline_strings = 1


let g:clojure_syntax_keywords  = {
  \ 'clojureFunc': ['deftest']}

let g:clojure_fuzzy_indent_patterns = ['^with', '^def', '^let', '^mf?n?/providing', '^mf?n?/verifying']

" om/next lispwords (defui is already matched by the default '^def' entry in clojure_fuzzy_indent_patterns)
setl lispwords+=query
setl lispwords+=render
setl lispwords+=initLocalState,componentDidMount,componentWillMount,componentWillUnmount,componentWillUpdate,componentWillReceiveProps

setl lispwords+=authorized-action

setl lispwords+=go-loop
setl lispwords+=mfn/verifying,mfn/providing
" TODO: manifold stuff? let-flow, any other with-thing from other libs? or is that included in default fuzzy stuff

Plug 'tpope/vim-fireplace' " Note: stay on {'branch': 'v1.1'} sez Kevin
" require :reload current namespace
nmap <leader>rr  :w<CR>:Require<CR>
" require :reload-all current namespace
nmap <leader>ra  :w<CR>:Require!<CR>
" run the test at or above the cursor
nmap <leader>rt  :w<CR>:.RunTests<CR>
" run all tests in namespace
nmap <leader>rnt :w<CR>:RunTests<CR>

" gd in clojure files uses fireplace go to definition
autocmd FileType clojure nmap <buffer> gd ]<C-D>

" vim-classpath lets you use fireplace without a repl session, but each invocation takes several seconds :/
"Plug 'tpope/vim-classpath'

" Add and remove clojure imports
Plug 'guns/vim-slamhound'
nnoremap <Leader>sh :w<CR>:Slamhound<CR>

" Look in to this when it supports ranges https://github.com/venantius/vim-cljfmt/issues/9
"Plug 'venantius/vim-cljfmt'

Plug 'luochen1990/rainbow'
let g:rainbow_active = 1
let g:rainbow_conf = {
    \ 'ctermfgs': ['darkmagenta', 'darkblue', 'red', 'darkcyan', 'darkred', 'brown', 'darkgreen'],
    \ 'guifgs': ['darkmagenta', 'darkblue', 'red', 'darkcyan', 'darkred', 'brown', 'darkgreen']
\ }

" Clojure plugins to try:
" abbrev break! (com.gfredericks.debug-repl.http-intercept/break!)
" command! -buffer LoadDebugger :Eval (require 'com.gfredericks.debug-repl.http-intercept 'com.gfredericks.debug-repl)<CR>
" command! -buffer Unbreak :Eval (com.gfredericks.debug-repl/unbreak!)
" command! -buffer WaitForBreak :Eval (com.gfredericks.debug-repl.http-intercept/wait-for-breaks)
" setlocal foldmethod=syntax " non local? want this all the time?
" nnoremap <buffer> gs :<C-u>exe "norm \<Plug>FireplaceDjump"<CR>zOzz:call halo#run({'shape': 'cross2'})<CR>
" TODO search for other uses of vim-halo in this guy's config?
" https://github.com/guns/vim-clojure-highlight
" https://github.com/clojure-vim/clj-refactor.nvim
" https://github.com/markwoodhall/vim-figwheel
" https://github.com/gfredericks/debug-repl

Plug 'snoe/vim-sexp' "This is a fork of guns/vim-sexp with the addition of not moving the cursor when slurping and barfing
let g:sexp_enable_insert_mode_mappings = 1

" NOTE! To get the default meta mappings to work you need to make sure your keyboard maps Option to a true Meta.
" On iTerm2 you can do this in Preferences -> Profiles -> Keys. The built in " terminal app also supports meta.
" Many terminals just support alt, which is an escape followed by the key.
"
" In Mac OS option+a key produces a special character. Here we just map those special characters to get the same effect.
"
" NOTE: Option-Shift-k is special. It produces the apple logo but only if the focus is on a "text" area. Some terminals
" support this and some don't.
let g:sexp_mappings = {
    \ 'sexp_move_to_prev_element_head': '∫',
    \ 'sexp_move_to_next_element_head': '∑',
    \ 'sexp_move_to_prev_element_tail': 'g´',
    \ 'sexp_move_to_next_element_tail': '´',
    \ 'sexp_flow_to_prev_close':        '“',
    \ 'sexp_flow_to_next_open':         '‘',
    \ 'sexp_flow_to_prev_open':         '”',
    \ 'sexp_flow_to_next_close':        '’',
    \ 'sexp_flow_to_prev_leaf_head':    'ı',
    \ 'sexp_flow_to_next_leaf_head':    '„',
    \ 'sexp_flow_to_prev_leaf_tail':    '˝',
    \ 'sexp_flow_to_next_leaf_tail':    '´',
    \ 'sexp_swap_list_backward':        '˚',
    \ 'sexp_swap_list_forward':         '∆',
    \ 'sexp_swap_element_backward':     '˙',
    \ 'sexp_swap_element_forward':      '¬',
    \ 'sexp_emit_head_element':         'Ô',
    \ 'sexp_emit_tail_element':         '',
    \ 'sexp_capture_prev_element':      'Ó',
    \ 'sexp_capture_next_element':      'Ò',
    \ }
" Alternative: Copy M-* mappings to be the special vim alt escape sequence.
" This sucks becauase if you hit escape then a letter too fast it'll trigger.
"let g:sexp_mappings = {
"    \ 'sexp_move_to_prev_element_head': 'b',
"    \ 'sexp_move_to_next_element_head': 'w',
"    \ 'sexp_move_to_prev_element_tail': 'ge',
"    \ 'sexp_move_to_next_element_tail': 'e',
"    \ 'sexp_flow_to_prev_close':        '[',
"    \ 'sexp_flow_to_next_open':         ']',
"    \ 'sexp_flow_to_prev_open':         '{',
"    \ 'sexp_flow_to_next_close':        '}',
"    \ 'sexp_flow_to_prev_leaf_head':    'B',
"    \ 'sexp_flow_to_next_leaf_head':    'W',
"    \ 'sexp_flow_to_prev_leaf_tail':    'G',
"    \ 'sexp_flow_to_next_leaf_tail':    'E',
"    \ 'sexp_swap_list_backward':        'k',
"    \ 'sexp_swap_list_forward':         'j',
"    \ 'sexp_swap_element_backward':     'h',
"    \ 'sexp_swap_element_forward':      'l',
"    \ 'sexp_emit_head_element':         'J',
"    \ 'sexp_emit_tail_element':         'K',
"    \ 'sexp_capture_prev_element':      'H',
"    \ 'sexp_capture_next_element':      'L',
"    \ }

" Manipulate surrounds. Super useful for non-lispy languages too
Plug 'tpope/vim-surround'

" Enables repeating actions added by other plugins (e.g. vim-surround) with the builtin . command
Plug 'tpope/vim-repeat'

" Underlines current word (easy to see where variables or :keywords are used further down the code)
Plug 'itchyny/vim-cursorword'

" Guess the correct shiftwidth and expandtab based on the current file
Plug 'tpope/vim-sleuth'

Plug 'leafgarland/typescript-vim'

Plug 'rodjek/vim-puppet'
let g:puppet_align_hashes = 0

Plug 'Raimondi/delimitMate'
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
" Turn off ' for clojure
au FileType clojure let b:delimitMate_quotes = "\"`"

" aligning text by character. gl adds spaces before and gL after. e.g. glip=
" aligns on the = character in the paragraph. 3gli), aligns 3 commas in the
" inner parens.
Plug 'tommcdo/vim-lion'

" Git wrapper
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb' " Github support (e.g. :Gbrowse for source and commits). See README for token generation

" Mercurial wrapper inspired by fugitive
"Plug 'ludovicchabant/vim-lawrencium'

" Run :Obsess to start a vim session with automatic saving 'n stuff
" Use vim -S Session.vim to restore the session
Plug 'tpope/vim-obsession'

" Not using taboo since it was unpolished and broke some workflows
"Plug 'gcmt/taboo.vim'
" Required for Taboo to remember tab names when you save the current session
"set sessionoptions+=tabpages,globals
" A is the hotkey for renaming a tab (like my tmux config)
"nmap <Leader>A :TabooRename 

Plug 'bling/vim-airline'
set laststatus=2 " without this, vim-airline doesn't show until you create a split

" inactive windows should have the left section collapsed to only the filename of that buffer
let g:airline_inactive_collapse=1

" By default, airline uses a custom font with an awesome branch symbol. Sadly, I don't
" want to go to the trouble of patching the font everywhere I use vim, so use a more
" standard character.
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.branch = '∥'
let g:airline_left_sep = '»'
let g:airline_right_sep = '«'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline#extensions#ale#enabled = 1 " for linting

" let g:airline_extensions = ['branch', 'tabline']

" Disable the whitespace extension to speed things up
let g:airline#extensions#whitespace#enabled = 0

" enabled enhance tabline
let g:airline#extensions#tabline#enabled = 1
" configure how numbers are calculated in tab mode to tab number
let g:airline#extensions#tabline#tab_nr_type = 1

let g:airline#extensions#tabline#keymap_ignored_filetypes = ['vimfiler', 'nerdtree']

" trying to get rid of the filename in the top right...
"let g:airline#extensions#tabline#show_tab_type = 0

" Don't show buffer numbers in the tab line
let g:airline#extensions#tabline#buffer_nr_show = 0

" The `unique_tail` algorithm will display the tail of the filename, unless
" there is another file of the same name, in which it will display it along
" with the containing parent directory.
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" TODO: try these to get unique tail to work?
let g:airline#extensions#tabline#fnamemod = ':t:.'
"let g:airline#extensions#tabline#fnamecollapse = 0
"let g:airline#extensions#tabline#fnametruncate = 1

" enable/disable showing a summary of changed hunks under source control
let g:airline#extensions#hunks#enabled = 0 " I think this is super slow?
let g:airline#extensions#branch#enabled = 0 "slow
let g:airline_highlighting_cache = 1

set signcolumn=yes

"nmap <leader>gj <Plug>(GitGutterNextHunk)
"nmap <leader>gk <Plug>(GitGutterPrevHunk)
nmap <leader>gj <Plug>(coc-git-nextchunk)
nmap <leader>gk <Plug>(coc-git-prevchunk)
nmap <leader>gs <Plug>(coc-git-chunkinfo)

nmap <leader>hs :CocCommand git.chunkStage<CR>
nmap <leader>hu :CocCommand git.chunkUndo<CR>
nmap <leader>go :CocCommand git.browserOpen<CR>

" create text object for git chunks
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
omap ag <Plug>(coc-git-chunk-outer)
xmap ag <Plug>(coc-git-chunk-outer)))))

"TODO: hotkeys for https://github.com/neoclide/coc-git#commands

Plug 'dense-analysis/ale' " syntastic alternative
Plug 'aclaimant/syntastic-joker' " Needs ale and https://github.com/candid82/joker

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Toggle the two things that display signs in the gutter
nmap <silent> <Leader>gg :GitGutterBufferToggle<CR>
nmap <silent> <Leader>a :ALEToggleBuffer<CR>

" A global vim setting that GitGutter uses
set updatetime=200 " ms

" performance settings
let g:gitgutter_max_signs = 1000
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1

" LSP/Intellisense stuff
Plug 'neoclide/coc.nvim', {'branch': 'release'}
nmap <leader>rn <Plug>(coc-rename)

" TODO :help coc-status for integrations with airline

""""""""""" DEFAULT COC CONFIG FROM COC README """""""""""
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
""""""""""" END DEFAULT COC CONFIG FROM COC README """""""""""

Plug 'fanchangyong/a.vim' " Switch between source and header files easily (e.g. .cpp and .h)
" <Space>is is really not a good insert mode mapping.
" this fork of a.vim lets us override it
let g:InsertModeAlternateHeader = 0

Plug 'vimwiki/vimwiki'
let g:vimwiki_url_maxsave=0 " Disable link shortening
let g:vimwiki_conceallevel=0

let project_wiki = {}
let project_wiki.path = '~/vimwiki/main/'
let project_wiki.nested_syntaxes = {'python': 'python', "c++": 'cpp'}
let project_wiki.syntax = 'markdown'
let project_wiki.ext = '.md'

" Plugins are sourced after the .vimrc. vimwiki will not map shortcuts
" if there is already a map to that function, so make a dummy map to
" <Plug>VimwikiIndex so it won't try to map <Leader>ww
nmap <silent> <Leader>2dummy <Plug>VimwikiIndex
nmap <silent> <Leader>ww <Plug>VimwikiTabIndex
nmap <silent> <Leader>wt <Plug>VimwikiIndex

" TODO: notational velocity like searching of notes
" nmap <Leader>wp :Files ~/git/vimwiki/<CR>

let garden_wiki = {}
let garden_wiki.path = '~/vimwiki/garden/'
let garden_wiki.syntax = 'markdown'
let garden_wiki.ext = '.md'
nmap <silent> <Leader>wg 2<Plug>VimwikiTabIndex

let g:vimwiki_list = [project_wiki, garden_wiki]

" Plugin for expanding abbreviations
" Plug 'mattn/emmet-vim'

"Plug 'jnwhiteh/vim-golang'
" Run gofmt whenever I save go files
"autocmd FileType go autocmd BufWritePre <buffer> Fmt
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
" update imports and fmt (can be slow on large projects, use :GoImports in that case
let g:go_fmt_command = "goimports"
" don't show parse errors on fmt
let g:go_fmt_fail_silently = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
"let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1

let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
" TODO set up mapping for :GoAlternate to switch between src and test file
" autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
" autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
" autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
" autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')))))

"autocmd FileType go nmap <Leader>i <Plug>(go-info)
" show fn info every time your cursor is over a valid identifier
let g:go_auto_type_info = 1
" TODO use :GoReferrers, Callees, Implements, and :<range>GoPlay

"Plug 'lepture/vim-jinja'

" Brewfile syntax
Plug 'bfontaine/Brewfile.vim'

" make accidentally holding shift for too long work, like :Wq
Plug 'takac/vim-commandcaps'

"Plug 'Lokaltog/vim-easymotion'
"let g:EasyMotion_leader_key = '<Leader>'

" Plug 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'

let g:gruvbox_contrast_dark='hard'
set background=dark

" Plugins become visible to Vim after this call
call plug#end()

" ":silent! colorscheme solarized
:silent! colorscheme gruvbox

" map chords of simultaneously pressed keys
call arpeggio#load()
"Arpeggio inoremap jk <Esc>:w<CR> " this turned out to be too finicky. You have to hit the keys *exactly* at the same time with my settings
inoremap kj <Esc>:w<CR>
inoremap jk <Esc>:w<CR>

" window movement
Arpeggio nnoremap wj <C-w>j
Arpeggio nnoremap wk <C-w>k
Arpeggio nnoremap wl <C-w>l
Arpeggio nnoremap wh <C-w>h
Arpeggio nnoremap WJ <C-w>J
Arpeggio nnoremap WK <C-w>K
Arpeggio nnoremap WL <C-w>L
Arpeggio nnoremap WH <C-w>H

" Underline the matching parenthesis (default vim behavior is highlight)
"highlight MatchParen cterm=NONE,underline,bold ctermbg=NONE ctermfg=NONE gui=NONE,underline,bold guibg=NONE guifg=NONE

set re=1
syntax on
"set hidden             " if you open a file over another one, don't display the unsaved changes message. coc recommends setting this
set cmdheight=2        " (coc) more space for displaying messages
set shortmess+=c       " (coc) don't pass messages to |ins-completion-menu|.
set ruler              " show the line number on the bar
set bs=2               " make backspace work
set autoread           " autoreload the file after !shell commands
set autowrite          " auto write the contents of the file if you call `:make` (vim-go plugin uses this too)
set magic              " mostly same regex rules as grep
set scrolloff=3        " leave 3 lines between the cursor and the top/bot of screen
set showcmd            " show a command in progress in the bar (eg a long command involving <leader>)
set spl=en_us          " use English for spellchecking
set nospell            " don't spellcheck by default
set showmatch          " highlight the matching brace/paren/bracket
set nohlsearch         " don't highlight search (<leader>hl toggles)
set incsearch          " start searching when you type the first character
set nohidden           " when I close a tab, remove the buffer
set showmode           " show insert/visual/normal in the status line
set cpo+=J             " a sentence has to be followed by two spaces after a ., !, or ?
set fo-=c              " automatically text wrap comments
set fo-=o              " automatically insert current comment leader when you hit o or O
set switchbuf=usetab,newtab " Switch to existing tab if the buffer is open
set history=9999       " the default is 20... lol

set tabstop=2          " I prefer 2 spaces for tab
set shiftwidth=2
set shiftround         " Round indent to nearest multiple of shiftwidth
set smarttab
set expandtab
set autoindent
"set smartindent

" Default new splits to bottom and right
set splitbelow
set splitright

" Make temp files go somewhere out of the way by prepending better directories
set undolevels=200 "maximum number of changes you can undo (stored in memory)

set undodir-=.
set undodir^=~/.vim/undodir
set directory-=.
set directory^=~/.vim/swpdir
set backupdir-=.
set backupdir^=~/.vim/backupdir

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

filetype indent on
filetype plugin indent on

"don't use spaces for makefiles...
autocmd FileType make setlocal noexpandtab tabstop=2 shiftwidth=2

" copy paste mode:
" the `paste` option makes it so pasting code won't be messed up by autoindent
inoremap <F2> <Esc>:set invpaste paste?<CR>i
nnoremap <F2> :set invpaste paste?<CR>

" a.vim: plugin to let you switch between .cpp and .h files quickly
let g:alternateNoDefaultAlternate = 1 " don't open a file which doesn't exist if no alternate found
let g:alternateRelativeFiles = 1      " something about the cwd
" map C-c c to switch between source and header like emacs
" use :up instead of :w so you don't write the file when you didn't change anything and confuse make
noremap <C-C><C-C> <Esc>:up<CR>:A<CR>

set wildignore+=*/venv/*,*/_site/*,*/target/*
set wildignore+=*\\venv\\*,*\\_site\\*,*\\target\\*
set wildignore+=tags,Session.vim

" Set up the tabline so it won't show the hugely long ugly paths
if exists("+guioptions")
   set go-=a go-=e go+=t
endif

" Abbreviations for c/cpp files. <buffer> means it's local to the buffer.
autocmd FileType cpp :iabbrev <buffer> #i #include
autocmd FileType cpp :iabbrev <buffer> #d #define
autocmd FileType cpp :iabbrev <buffer> string std::string
autocmd FileType cpp :iabbrev <buffer> vector std::vector
autocmd FileType cpp :iabbrev <buffer> wstring std::wstring
" fix double std:: namespace resolutions sometimes caused by my abbreviations
noremap <leader>std <Esc>:%s/std::std::/std::/g<CR>

" Bash abbreviations
autocmd FileType sh :iabbrev <buffer> shebang #!/usr/bin/env bash<CR><CR># unofficial bash "strict mode"<CR>set -euo pipefail<CR>IFS=$'\n\t'
autocmd FileType sh :iabbrev <buffer> usestrict # unofficial bash "strict mode"<CR>set -euo pipefail<CR>IFS=$'\n\t'

" Avoid using the escape key because it's so far away! just mash j and k
set timeoutlen=450 " the default 1 second pause is too much

nnoremap <Leader>wa :wa<CR>
nnoremap <Leader>w :w<CR>

" Use tab instead of escape to cancel prefix keys before a command in normal mode
"nnoremap <Tab> <Esc>  " (This breaks Ctrl-I since it is <TAB>)

" Use tab instead of escape to cancel operater pending commands in normal mode (eg <leader>cmd)
onoremap <Tab> <Esc>

" Use tab instead of escape to cancel stuff in visual mode
vnoremap <Tab> <Esc>gV

" Display whitespace
set listchars=tab:▸\ ,eol:¬,trail:·
" toggle
nmap <leader>l :set list!<CR>

" Make Y behave like other capitals
nnoremap Y y$

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" ctags settings
" search for a file named "tags" from the current directory down to root
set tags=./tags;/
" L and K go up and down the tag stack, H and L go left/right.
"noremap <C-K> <C-]>
"noremap <C-J> <C-T>
"noremap <C-L> :tn<CR>
"noremap <C-H> :tp<CR>
" Control-T opens the tag in a new tab
noremap <C-T> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" Control-Y opens the tag in a vertical split
"noremap <C-Y> :vsp <CR>:exec("tag ".expand("<cword>"))<CR> " this override zencoding.vim
" TODO: use "autocmd BufEnter * silent! lcd %:p:h" to change cwd to file being edited. This could change tag files when I visit a dependency :)
" or manually cd, "nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>"

" print the path of the file being edited
nnoremap <leader>pwd :echo expand('%:p')<CR>

" quickly edit vimrc with ,ev when I have an idea (mnemomic: edit vimrc)
:nnoremap <leader>ev :split $MYVIMRC<cr>
" reload vimrc with ,sv (mnemomic: source vimrc)
:nnoremap <leader>sv :source $MYVIMRC<cr>

" turn syntax highlighting on and off
:nnoremap <leader>hl :set hlsearch! hlsearch?<CR>
" if you have hlsearch on my default, you can set <CR> to clear the highlighting
"nnoremap <CR> :noh<CR><CR>

" Remove trailing whitespace
:nnoremap <leader>sw :%s/\s\+$//e<CR>
"autocmd BufWritePre * :%s/\s\+$//e

" Let space toggle a fold if we are in one, otherwise do the default behavior
nnoremap <silent> <Space> @=(foldlevel('.')?'zA':"\<Space>")<CR>
vnoremap <Space> zf

" Map C-l to toggle to the last tab (this overrides 'Clear and redraw screen', so use :redraw! instead)
let g:lasttab = 1
nmap <C-l> :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" duplicate current tab
nnoremap <leader>ts :tab split<CR>

" Save and load the folds each time we open/close a file (as long as it has a name)
" VimEnter because: http://stackoverflow.com/questions/8854371/vim-how-to-restore-the-cursors-logical-and-physical-positions
au BufWinLeave .+ mkview
au VimEnter .+ silent loadview

" Remap gf to open in new tabs
nmap gf <C-W>gf
vmap gf <C-W>gf

" tab completion of file names
set wildmenu
set wildmode=list:full

"ctrl-p/ctrl-n completion is too slow with includes
set complete-=i

" set path so I can use :tabf[ind] and :find to open files w/o typing the whole path
set path=.,,**

if &term =~ '256color'
  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screen.
  " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" Allow specific vim settings to exist per computer. I mostly use this for
" custom mappings for work which I don't want to publish to github.
if filereadable($HOME . "/.vimrc.local")
   source ~/.vimrc.local
endif
