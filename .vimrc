set rtp+=~/.vim/bundle/Vundle.vim
set backspace=indent,eol,start
set directory=/tmp//
set nowrap
set hidden
set nu
set tabstop=2

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'tomasr/molokai'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdcommenter'
call vundle#end()

let mapleader = ","
map <space>m :NERDTreeToggle<cr>
map <space>f :CtrlP<cr>
map <leader>. :BufExplorer<cr>
map <leader><leader> :e#<cr>

let NERDTreeQuitOnOpen=1
set laststatus=2
syntax enable
silent! colorscheme molokai
filetype plugin on
filetype indent on
