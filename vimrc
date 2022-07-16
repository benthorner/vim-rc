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

" better highlighting for visual selection lines / text
hi Visual ctermbg=30 ctermfg=16

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
Plugin 'jlanzarotta/bufexplorer'
Plugin 'tomasr/molokai'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'yegappan/grep'
call vundle#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" fzf (search)
""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:OpenFileAtRow(line) abort
  let file = split(a:line, ':')[0]
  let line = split(a:line, ':')[1]
  execute "e "."+".line." ".fnameescape(file)
endfunction

command! FzfAg call fzf#run({
\  'source': 'ag .',
\  'sink': function('s:OpenFileAtRow'),
\  'options': '--color=16,fg:5 --exact'
\})

command! FzfFiles call fzf#run({
\  'source': 'git ls-files || find .',
\  'sink': 'e',
\  'options': '--color=16,fg:5'
\})

map <leader>f :FzfFiles<cr>
map <leader>g :FzfAg<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" NERDTree (file explorer)
""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>m :NERDTreeToggle<cr>
let NERDTreeQuitOnOpen=1

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
map <leader>wq :bd<cr>
autocmd BufWrite * StripWhitespace

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" syntax highlighting
""""""""""""""""""""""""""""""""""""""""""""""""""""""
silent! colorscheme molokai
syntax enable

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" viewports
""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>ww <c-w><c-w>
