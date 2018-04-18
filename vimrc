set rtp+=~/.vim/bundle/Vundle.vim
set backspace=indent,eol,start
set directory=/tmp//
set nowrap
set hidden
set nu
set tabstop=2
set shiftwidth=2
set expandtab
set hlsearch
set cursorline

call vundle#begin()
Plugin 'tpope/vim-abolish'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'w0rp/ale'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'tomasr/molokai'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ntpeters/vim-better-whitespace'
call vundle#end()

let mapleader = ","
map <leader>m :NERDTreeToggle<cr>
map <leader>f :CtrlP<cr>
map <leader>. :BufExplorer<cr>
map <leader><leader> :e#<cr>

let NERDTreeQuitOnOpen=1
let g:ale_lint_on_text_changed="never"
set laststatus=2
autocmd BufWrite * StripWhitespace

syntax enable
silent! colorscheme molokai
filetype plugin on
filetype indent on
