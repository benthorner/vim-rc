set rtp+=~/.vim/bundle/Vundle.vim
set backspace=indent,eol,start
set directory=/tmp//
set clipboard=unnamed
set nowrap
set hidden
set nu
set tabstop=2
set shiftwidth=2
set expandtab
set hlsearch
set cursorline
set re=1
set mouse=n

call vundle#begin()
Plugin 'tpope/vim-abolish'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'tomasr/molokai'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ntpeters/vim-better-whitespace'
call vundle#end()

let mapleader = ","
map <leader>m :NERDTreeToggle<cr>
map <leader>f :CtrlP<cr>
map <leader>. :BufExplorer<cr>
map <leader><leader> :e#<cr>

let NERDTreeQuitOnOpen=1
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
set laststatus=2
autocmd BufWrite * StripWhitespace

syntax enable
silent! colorscheme molokai
hi Visual ctermbg=30 ctermfg=16
filetype plugin on
filetype indent on
