set nocompatible
filetype off   " required by vundle

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" The rally plugin looked promising but I don't think it's ready for production...
"Bundle 'davidpthomas/vim4rally'

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'tpope/vim-markdown'

Bundle 'myusuf3/numbers.vim'
set number " Otherwise numbers won't show up in insert mode


" Fuzzy finder. I mostly use this for opening new tabs.
Bundle 'kien/ctrlp.vim'
" don't manage working directory (since we use p4 at work)
let g:ctrlp_working_path_mode = 0

" open newly created files in a new tab
let g:ctrlp_open_new_file = 't'

" open multiple files in tabs
let g:ctrlp_open_multiple_files = 't'

" switch to a tab if a file is already open
let g:ctrlp_switch_buffer = 2

" make opening new tabs work like :tabnew (inserts new tab into next position in list)
let g:ctrlp_tabpage_position = 'a'


" Git wrapper
Bundle 'tpope/vim-fugitive'

" Mercurial wrapper inspired by fugitive
Bundle 'ludovicchabant/vim-lawrencium'

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

" Gutter for displaying what lines changed since last commit (git, hg, etc)
Bundle 'mhinz/vim-signify'
" only detect these VCS (performance)
let g:signify_vcs_list = [ 'git', 'hg' ]

" jump between hunks!
let g:signify_mapping_next_hunk = '<leader>gj'
let g:signify_mapping_prev_hunk = '<leader>gk'

" Tell signify to overwrite existing signs. This boosts performance a tad at the
" expense of compatibility with any other plugins.
let g:signify_sign_overwrite = 0

" More opportunistically update signify. Side effect of saving the buffer on focus or bufenter
let g:signify_update_on_focusgained = 0
let g:signify_update_on_bufenter = 0

Bundle 'vim-scripts/a.vim'

Bundle 'mattn/zencoding-vim'

Bundle 'jnwhiteh/vim-golang'
" Run gofmt whenever I save go files
"autocmd FileType go autocmd BufWritePre <buffer> Fmt

Bundle 'lepture/vim-jinja'

" make stuff like :Wq work!
Bundle 'takac/vim-commandcaps'

" Ack is better than grep
Bundle 'mileszs/ack.vim'

" Bundle 'vim-scripts/VimClojure'

"Bundle 'Lokaltog/vim-easymotion'
"let g:EasyMotion_leader_key = '<Leader>'

Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Bundle 'altercation/vim-colors-solarized'
let g:solarized_contrast="low"
colorscheme solarized
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
set incsearch          " start searching when you type the first character
set nohidden           " when I close a tab, remove the buffer
set showmode           " show insert/visual/normal in the status line

set tabstop=3          " I prefer 3 spaces for tab
set shiftwidth=3
set smarttab
set expandtab
set autoindent
set smartindent


let mapleader=","

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

if has("autocmd")
  filetype indent on
endif

" Abbreviations for c/cpp files. <buffer> means it's local to the buffer.
autocmd FileType cpp :iabbrev <buffer> #i #include
autocmd FileType cpp :iabbrev <buffer> #d #define

"don't use spaces for makefiles...
autocmd FileType make setlocal noexpandtab tabstop=3 shiftwidth=3

" copy paste mode:
" the `paste` option makes it so pasting code won't be messed up by autoindent
inoremap <F2> :set invpaste paste?<CR>
" in normal mode, turn off signify and line numbers so I can copy and paste by selecting text
nnoremap <F2> :NumbersToggle<CR>:setlocal number!<CR>:SignifyToggle<CR>

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

" prefix std namespace TODO: only do this in cpp files
"abb string std::string
"abb vector std::vector
"abb wstring std::wstring
" map F4 to fix double std:: namespace resolutions sometimes caused by my abbreviations
noremap <F4> <Esc>:%s/std::std::/std::/g<CR>

" Avoid using the escape key because it's so far away!
inoremap jj <Esc>
" Even faster, just mash j and k (side effect: saves buffer)
inoremap jk <Esc>:w<CR>
inoremap kj <Esc>:w<CR>
set timeoutlen=450 " the default 1 second pause is too much for jk

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
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

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

" Perforce mappings
nmap <leader>pe :!p4 edit <CR>:e!<CR>
nmap <leader>pr :!p4 revert <CR>:e!<CR>
nmap <leader>ps :!p4 sync <CR>:e!<CR>

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
