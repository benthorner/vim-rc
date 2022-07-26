""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" general
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","

filetype indent on               " auto indent by file type
filetype plugin on               " auto set options by type

set backspace=indent,eol,start   " smart whitespace removal
set directory=/tmp//             " hide away temp files
set clipboard=unnamed            " use system clipboard
set nowrap                       " don't wrap long lines
set hidden                       " switch without saving
set nu                           " show line numbers
set tabstop=2                    " spaces on tab key press
set softtabstop=-1               " but convenient backspace
set shiftwidth=2                 " new line indent spaces
set expandtab                    " convert tabs -> spaces
set hlsearch                     " highlight all matches
set cursorline                   " highlight current line
set re=1                         " fast syntax highlight
set mouse=n                      " enable mouse clicks
set incsearch                    " incremental search
set laststatus=2                 " always show airline
set mmp=5000                     " https://github.com/vim/vim/issues/2049
set scrolloff=10                 " scroll boundary margin

" copy current file path to clipbaord (e.g. for git blame)
map ff :let @+ = expand("%")<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" packages
""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'tpope/vim-abolish'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'tomasr/molokai'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
call vundle#end()

"bat

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" fzf (search)
""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_preview_window = ['up:50%']
let g:fzf_action = {'ctrl-q': function('s:build_quickfix_list')}

let $FZF_DEFAULT_OPTS = '
\  --bind ctrl-a:select-all
\  --history /tmp/fzf-history
\  --color=fg:5,fg+:5,hl:2,hl+:10,bg+:233
\'

command! -bang -nargs=* Ag call fzf#vim#ag(
\  <q-args>,
\  '--color-path "0;35"',
\  fzf#vim#with_preview({'options': ['--exact']}),
\  <bang>0
\)

command! -bang -nargs=* Files call fzf#vim#gitfiles(
\  <q-args>,
\  fzf#vim#with_preview({'options': []}),
\  <bang>0
\)

map <leader>f :Files!<cr>
map <leader>g :Ag!<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" NERDTree (file explorer)
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 60

map <leader>m :NERDTreeToggle<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" fugitive (Git/Hub)
""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>b :GBrowse master:%<cr>
let g:airline#extensions#branch#enabled = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>. :BufExplorer<cr>
map <leader><leader> :e#<cr>
autocmd BufWrite * StripWhitespace

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" syntax highlighting
""""""""""""""""""""""""""""""""""""""""""""""""""""""
silent! colorscheme molokai
syntax enable

hi CursorLine ctermbg=17
hi Visual ctermbg=17
hi QuickFixLine ctermbg=17

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" viewports
""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>ww <c-w><c-w>
map <leader>we <c-w>j<c-w>q<cr>
