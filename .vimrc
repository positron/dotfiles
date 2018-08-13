set nocompatible
filetype off   " required by vundle

let mapleader=" "

" Install vim-plug if it is not there
" Note: To update vim-plug, run `:PlugUpgrade`
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Install fzf globally. Do this through vim since the fzf repo also has a basic vim wrapper
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim' " Add better bindings than the default fzf vim plugin

" Jump to the existing window if possible
let g:fzf_buffers_jump = 1

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

Plug 'tpope/vim-markdown'

" Clojure support
" vim-classpath takes several seconds the first time you open a java or clojure file in a
" new project
"Plug 'tpope/vim-classpath'
Plug 'tpope/vim-fireplace'
nmap <leader>r :w<CR>:Require<CR>
nmap <leader>rr :w<CR>:Require!<CR>
"Plug 'vim-scripts/paredit.vim'

" Look in to this when it supports ranges https://github.com/venantius/vim-cljfmt/issues/9
"Plug 'venantius/vim-cljfmt'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

" Guess the correct shiftwidth and expandtab based on the current file
Plug 'tpope/vim-sleuth'

Plug 'leafgarland/typescript-vim'

Plug 'rodjek/vim-puppet'
let g:puppet_align_hashes = 0

Plug 'Raimondi/delimitMate'
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

" aligning text by character. gl adds spaces before and gL after. e.g. glip=
" aligns on the = character in the paragraph. 3gli), aligns 3 commas in the
" inner parens.
Plug 'tommcdo/vim-lion'

" Fuzzy finder for finding files
Plug 'ctrlpvim/ctrlp.vim'

" open newly created files in a new tab
let g:ctrlp_open_new_file = 't'

" open multiple files in tabs
let g:ctrlp_open_multiple_files = 't'

" switch to a tab if a file is already open
let g:ctrlp_switch_buffer = 2

" make opening new tabs work like :tabnew (inserts new tab into next position in list)
let g:ctrlp_tabpage_position = 'a'

" list files that start with a .
let g:ctrlp_show_hidden = 1

" ctrlp uses wildignore. These files we just want ctrlp alone to ignore though
let g:ctrlp_custom_ignore = {
  \ 'dir': 'node_modules\|bower_components\|dist\|typings\|.git\|tmp',
  \ }

" Receive tmux focus events to update fugitive, gitgutter, etc
Plug 'tmux-plugins/vim-tmux-focus-events'

" Git wrapper
Plug 'tpope/vim-fugitive'

" Run :Obsess to start a vim session with automatic saving 'n stuff
Plug 'tpope/vim-obsession'

" Mercurial wrapper inspired by fugitive
"Plug 'ludovicchabant/vim-lawrencium'

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

" Disable the whitespace extension to speed things up
let g:airline#extensions#whitespace#enabled = 0

" enabled enhance tabline
let g:airline#extensions#tabline#enabled = 1
" configure how numbers are calculated in tab mode to tab number
let g:airline#extensions#tabline#tab_nr_type = 1

" Just show the filename (no path) in the tab
let g:airline#extensions#tabline#fnamemod = ':t'

" trying to get rid of the filename in the top right...
"let g:airline#extensions#tabline#show_tab_type = 0

" Don't show buffer numbers in the tab line
let g:airline#extensions#tabline#buffer_nr_show = 0

" The `unique_tail` algorithm will display the tail of the filename, unless
" there is another file of the same name, in which it will display it along
" with the containing parent directory.
" let g:airline#extensions#tabline#formatter = 'unique_tail'

" enable/disable showing a summary of changed hunks under source control
let g:airline#extensions#hunks#enabled = 1

" Change the colors of ctrl-p to match airline
let g:airline#extensions#ctrlp#color_template = 'normal'

" Gutter for displaying what lines changed since last commit
Plug 'airblade/vim-gitgutter'

nmap <leader>gj <Plug>GitGutterNextHunk
nmap <leader>gk <Plug>GitGutterPrevHunk
" gitgutter maps <leader>hs and <leader>hr to stage and revert hunks

" performance settings
let g:gitgutter_max_signs = 1000
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1

Plug 'fanchangyong/a.vim'
" <Space>is is really not a good insert mode mapping.
" this fork of a.vim lets us override it
let g:InsertModeAlternateHeader = 0

Plug 'vimwiki/vimwiki'
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

"Plug 'lepture/vim-jinja'

" Brewfile syntax
Plug 'bfontaine/Brewfile.vim'

" make accidentally holding shift for too long work, like :Wq
Plug 'takac/vim-commandcaps'

" Ack is better than grep
Plug 'mileszs/ack.vim'
nnoremap <Leader>ack :Ack 

"Plug 'Lokaltog/vim-easymotion'
"let g:EasyMotion_leader_key = '<Leader>'

" Plug 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Plug 'altercation/vim-colors-solarized'
set background=dark

" Plugins become visible to Vim after this call
call plug#end()

:silent! colorscheme solarized

syntax on
set ruler              " show the line number on the bar
set bs=2               " make backspace work
set autoread           " autoreload the file after !shell commands
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

set tabstop=3          " I prefer 3 spaces for tab
set shiftwidth=3
set shiftround         " Round indent to nearest multiple of shiftwidth
set smarttab
set expandtab
set autoindent
set smartindent

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

if has("autocmd")
  filetype indent on
endif

"don't use spaces for makefiles...
autocmd FileType make setlocal noexpandtab tabstop=3 shiftwidth=3

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

" note: ctrlp uses wildignore
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
inoremap jk <Esc>:w<CR>
inoremap kj <Esc>:w<CR>
set timeoutlen=350 " the default 1 second pause is too much for jk

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
noremap <C-K> <C-]>
noremap <C-J> <C-T>
noremap <C-L> :tn<CR>
noremap <C-H> :tp<CR>
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
" TODO: maybe map this to double space?
"nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
"vnoremap <Space> zf

" Map C-l to toggle to the last tab (this overrides 'Clear and redraw screen', so use :redraw! instead)
let g:lasttab = 1
nmap <C-l> :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Save and load the folds each time we open/close a file (as long as it has a name)
" VimEnter because: http://stackoverflow.com/questions/8854371/vim-how-to-restore-the-cursors-logical-and-physical-positions
au BufWinLeave .+ mkview
au VimEnter .+ silent loadview

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
