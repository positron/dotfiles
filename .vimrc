set nocompatible
filetype off   " required by vundle

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" The rally plugin looked promising but I don't think it's ready for production...
"Bundle 'davidpthomas/vim4rally'

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'tpope/vim-markdown'

"Bundle "myusuf3/numbers.vim"
"nnoremap <F3> :NumbersToggle<CR>

Bundle 'kien/ctrlp.vim'

Bundle 'vim-scripts/a.vim'

Bundle 'mattn/zencoding-vim'

Bundle 'Lokaltog/vim-easymotion'
let g:EasyMotion_leader_key = '<Leader>'

Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
colorscheme Tomorrow-Night

syntax on
set background=dark
set ruler
set bs=2 "make backspace work
set autoread
set magic "same regex as grep
set scrolloff=3

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

if has("autocmd")
  filetype indent on
endif

set showmatch
set incsearch

set tabstop=3
set shiftwidth=3
set smarttab
set expandtab
set autoindent
set smartindent
autocmd FileType ?akefile* setlocal noexpandtab tabstop=3 shiftwidth=3 "don't use spaces for makefiles...
autocmd FileType *.mak* setlocal noexpandtab tabstop=3 shiftwidth=3 "don't use spaces for makefiles...
autocmd FileType *.mk* setlocal noexpandtab tabstop=3 shiftwidth=3 "don't use spaces for makefiles...

" Make it so pasting code won't be destroyed with autoindent
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Remove trailing whitespace on file save (all filetypes).
autocmd BufWritePre * :%s/\s\+$//e

" a.vim: plugin to let you switch between .cpp and .h files quickly
let g:alternateNoDefaultAlternate = 1 " don't open a file which doesn't exist if no alternate found
let g:alternateRelativeFiles = 1      " something about the cwd
" map C-c c to switch between source and header like emacs
" use :up instead of :w so you don't write the file when you didn't change anything and confuse make
noremap <C-C><C-C> <Esc>:up<CR>:A<CR>

" ctrlp.vim: plugin for opening files
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
let g:ctrlp_custom_ignore = '\v[\/]venv$'

" Set up the tabline so it won't show the hugely long ugly paths
if exists("+guioptions")
   set go-=a go-=e go+=t
endif

" gah this tabline is so hard to get right. The tabline works perfectly on most systems that
" I have vim installed on, but for some reason on Cygwin it is broken :-(
if has("win32unix")
   if exists("+showtabline")
      function MyTabLine()
         let s = ''
         let t = tabpagenr()
         let i = 1
         while i <= tabpagenr('$')
            let buflist = tabpagebuflist(i)
            let winnr = tabpagewinnr(i)
            "let s .= '%' . i . 'T'
            "let s .= (i == t ? '%1*' : '%2*')
            "let s .= ' '
            "let s .= i . ':'
            "let s .= winnr . '/' . tabpagewinnr(i,'$')
            let s .= ' %*'
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
            let file = bufname(buflist[winnr - 1])
            let file = fnamemodify(file, ':p:t')
            if file == ''
               let file = '[No Name]'
            endif
            let s .= (i == t ? '%m' : '')
            "let s .= '%m'
            let s .= file
            let i = i + 1
         endwhile
         let s .= '%T%#TabLineFill#%='
         let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
         return s
      endfunction
      set stal=2
      set tabline=%!MyTabLine()
   endif
endif

" prefix std namespace
abb string std::string
abb vector std::vector
abb wstring std::wstring
" map F4 to fix double std:: namespace resolutions sometimes caused by my abbreviations
noremap <F4> <Esc>:%s/std::std::/std::/g<CR>

" Avoid using the escape key because it's so far away!
set timeoutlen=250 " millisecond pause after I type a j for it to go to the next key
inoremap jj <Esc>
inoremap jk <Esc>
"nnoremap <Tab> <Esc>   " Use tab instead of escape to cancel prefix keys before a command in normal mode (This breaks Ctrl-I since it is <TAB>)
onoremap <Tab> <Esc>   " Use tab instead of escape to cancel operater pending commands in normal mode (eg y)
vnoremap <Tab> <Esc>gV " Use tab instead of escape to cancel stuff in visual mode
"faster way to save
inoremap kk <Esc>:w<CR>

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
noremap <C-Y> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" TODO: use "autocmd BufEnter * silent! lcd %:p:h" to change cwd to file being edited. This could change tag files when I visit a dependency :)
" or manually cd, "nnoremap ,cd :cd %:p:h<CR>:pwd<CR>"

" ",pwd" will print the path of the file being edited
nnoremap ,pwd :echo expand('%:p')<CR>

" Let space toggle a fold if we are in one, otherwise do the default behavior
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Save and load the folds each time we open/close a file
" VimEnter because: http://stackoverflow.com/questions/8854371/vim-how-to-restore-the-cursors-logical-and-physical-positions
au BufWinLeave * mkview
au VimEnter * silent loadview

" tab completion of file names
set wildmenu
set wildmode=list:full

"ctrl-p/ctrl-n completion is too slow with includes
set complete-=i

" set path so I can use :tabf[ind] and :find to open files w/o typing the whole path
set path=.,,**

" Perforce mappings
nmap ,pe :!p4 edit <CR>:e!<CR>
nmap ,pr :!p4 revert <CR>:e!<CR>
nmap ,ps :!p4 sync <CR>:e!<CR>

if filereadable($HOME . "/.vimrc.local")
   source ~/.vimrc.local
endif
