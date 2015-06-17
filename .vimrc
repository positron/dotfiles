set nocompatible
filetype off   " required by vundle

let mapleader=" "

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'tpope/vim-markdown'

Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'

Bundle 'rodjek/vim-puppet'
let g:puppet_align_hashes = 0

Bundle 'Raimondi/delimitMate'
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

" Fuzzy finder for finding files
Bundle 'ctrlpvim/ctrlp.vim'

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

" Git wrapper
Bundle 'tpope/vim-fugitive'

" Mercurial wrapper inspired by fugitive
"Bundle 'ludovicchabant/vim-lawrencium'

Bundle 'bling/vim-airline'
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
Bundle 'airblade/vim-gitgutter'

nmap <leader>gj <Plug>GitGutterNextHunk
nmap <leader>gk <Plug>GitGutterPrevHunk
" gitgutter maps <leader>hs and <leader>hr to stage and revert hunks

" performance settings
let g:gitgutter_max_signs = 1000
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1

Bundle 'vim-scripts/a.vim'

Bundle 'vimwiki/vimwiki'
let project_wiki = {}
let project_wiki.path = '~/vimwiki/projects/'
let project_wiki.nested_syntaxes = {'python': 'python', "c++": 'cpp'}

" Plugins are sourced after the .vimrc. vimwiki will not map shortcuts
" if there is already a map to that function, so make a dummy map to
" <Plug>VimwikiIndex so it won't try to map <Leader>ww
nmap <silent> <Leader>2dummy <Plug>VimwikiIndex
nmap <silent> <Leader>ww <Plug>VimwikiTabIndex

let garden_wiki = {}
let garden_wiki.path = '~/vimwiki/garden/'
"nmap <Leader>wg 2<Leader>wt
nmap <silent> <Leader>wg 2<Plug>VimwikiTabIndex

let g:vimwiki_list = [project_wiki, garden_wiki]

" Plugin for expanding abbreviations
" Bundle 'mattn/emmet-vim'

"Bundle 'jnwhiteh/vim-golang'
" Run gofmt whenever I save go files
"autocmd FileType go autocmd BufWritePre <buffer> Fmt

"Bundle 'lepture/vim-jinja'

" make stuff like :Wq work!
Bundle 'takac/vim-commandcaps'

" Ack is better than grep
"Bundle 'mileszs/ack.vim'

" Bundle 'vim-scripts/VimClojure'

"Bundle 'Lokaltog/vim-easymotion'
"let g:EasyMotion_leader_key = '<Leader>'

" Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Bundle 'altercation/vim-colors-solarized'
"let g:solarized_contrast="low"
:silent! colorscheme solarized
set background=dark

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
set wildignore+=*/venv/*,*/_site/*
set wildignore+=*\\venv\\*,*\\_site\\*
set wildignore+=tags

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
autocmd FileType sh :iabbrev <buffer> shebang #/usr/bin/env bash<CR><CR># unofficial bash "strict mode"<CR>set -euo pipefail<CR>IFS=$'\n\t'
autocmd FileType sh :iabbrev <buffer> usestrict # unofficial bash "strict mode"<CR>set -euo pipefail<CR>IFS=$'\n\t'

" Avoid using the escape key because it's so far away!
inoremap jj <Esc>
" Even faster, just mash j and k (side effect: saves buffer)
inoremap jk <Esc>:w<CR>
inoremap kj <Esc>:w<CR>
set timeoutlen=400 " the default 1 second pause is too much for jk

" Use tab instead of escape to cancel prefix keys before a command in normal mode
"nnoremap <Tab> <Esc>  " (This breaks Ctrl-I since it is <TAB>)

" Use tab instead of escape to cancel operater pending commands in normal mode (eg <leader>cmd)
onoremap <Tab> <Esc>

" Use tab instead of escape to cancel stuff in visual mode
vnoremap <Tab> <Esc>gV

" Make Y behave like other capitals
nnoremap Y y$

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Make going to the next search result center on the line it's found in.
"map N Nzz
"map n nzz

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
