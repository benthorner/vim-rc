set rtp+=~/.vim/bundle/Vundle.vim
set backspace=indent,eol,start
set nowrap
set nu

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'tomasr/molokai'
Plugin 'mileszs/ack.vim'
call vundle#end()

let mapleader = " "
map <leader>m :NERDTreeToggle<cr>
map <leader>f :CtrlP<cr>
map ,. :BufExplorer<cr>
map ,, :e#<cr>

let NERDTreeQuitOnOpen=1
set laststatus=2
syntax enable
silent! colorscheme molokai
