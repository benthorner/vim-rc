""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" general
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = " "

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
set mmp=5000                     " https://github.com/vim/vim/issues/2049
set scrolloff=10                 " scroll boundary margin

" copy current file path to clipbaord (e.g. for git blame)
noremap ff :let @+ = expand("%")<cr>

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
Plugin 'preservim/tagbar'
Plugin 'ervandew/supertab'
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
\ --color=fg:21,hl:33
\ --color=fg+:13,bg+:-1,hl+:39
\'

command! -bang -nargs=* Rg call fzf#vim#grep(
\  "rg --line-number --no-heading -- ".shellescape(<q-args>),
\  1,
\  fzf#vim#with_preview({'options': ['--exact']}),
\  <bang>0
\)

command! -bang -nargs=* GitFiles call fzf#vim#gitfiles(
\  "--cached --others",
\  fzf#vim#with_preview({'options': ['--exact']}),
\  <bang>0
\)

noremap <leader>f :GitFiles!<cr>
noremap ,fg :Rg!<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" NERDTree (file explorer)
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 60

noremap <leader>m :NERDTreeToggle<cr>
noremap ,mf :NERDTreeFind<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" fugitive (Git/Hub)
""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap ,db :GBrowse master:%<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" BufExplorer
""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <leader>, :ToggleBufExplorer<cr>
let g:bufExplorerShowRelativePath = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <leader><leader> :e#<cr>
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
""" Tagbar
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_position = "topleft vertical"
let g:tagbar_foldlevel = 0
let g:tagbar_width = 60
let g:tagbar_sort = 0
let g:tagbar_map_showproto = ""  " overrides <space>

noremap <leader>t :TagbarToggle<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" vim-airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#tagbar#enabled = 0
