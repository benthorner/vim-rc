""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" general
""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype indent on               " auto indent by file type
filetype plugin on               " auto set options by type

set backspace=indent,eol,start   " smart whitespace removal
set noswapfile                   " no multi-user edit check
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = " "

" copy current file path to clipbaord (e.g. to run a test)
noremap <leader>p :let @+ = expand("%")<cr>

" switch to the previous buffer (e.g. a file and its test)
noremap <leader><leader> :e#<cr>

" quickly prune individual buffers (outside of bufexplorer)
noremap <leader><bs> :bd<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'tpope/vim-abolish'                " advanced find/replace
Plugin 'scrooloose/nerdtree'              " to view directory tree
Plugin 'bling/vim-airline'                " better status / tab lines
Plugin 'junegunn/fzf'                     " required for fzf.vim
Plugin 'junegunn/fzf.vim'                 " finding files and their contents
Plugin 'jlanzarotta/bufexplorer'          " to manage open buffers
Plugin 'tomasr/molokai'                   " a better color scheme
Plugin 'scrooloose/nerdcommenter'         " for toggling comments
Plugin 'ntpeters/vim-better-whitespace'   " remove trailing whitespace
Plugin 'tpope/vim-fugitive'               " required for vim-rhubarb
Plugin 'tpope/vim-rhubarb'                " to browse Git/Hub for files
Plugin 'preservim/tagbar'                 " to browse file ctags on-the-fly
Plugin 'ervandew/supertab'                " quick access to Vim autocomplete
call vundle#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" fzf[.vim]
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
\  "--cached --others --exclude-standard",
\  fzf#vim#with_preview({'options': ['--exact']}),
\  <bang>0
\)

noremap <leader>f :GitFiles!<cr>
noremap ,fg :Rg!<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" nerdtree
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 60

noremap <leader>m :NERDTreeToggle<cr>
noremap ,mf :NERDTreeFind<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" vim-fugitive/rhubarb
""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <leader>b :GBrowse master:%<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" bufexplorer
""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <leader>, :ToggleBufExplorer<cr>
let g:bufExplorerShowRelativePath = 1

" keep bufexplorer buffers in same order as tabline
let g:bufExplorerSortBy = 'number'

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" vim-better-whitespace
""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufWrite * StripWhitespace

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" molokai
""""""""""""""""""""""""""""""""""""""""""""""""""""""
silent! colorscheme molokai
syntax enable

" overrides to make current line easier to see (blue)
hi CursorLine ctermbg=17
hi Visual ctermbg=17
hi QuickFixLine ctermbg=17

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" tagbar
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
" reduce clutter in statusline to file name / lines
" format: A | B |   C   | X | Y | Z | warn/error
let g:airline_section_b = ''       " hide git info
let g:airline_section_x = ''       " hide file type
let g:airline_section_y = ''       " hide encoding
let g:airline_section_z = '%l/%L'  " just line nums
let g:airline_section_warning = '' " hide '...'
let g:airline_section_error = ''   " hide e.g. jedi

" avoid cluttering statusline with unnecessary info
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#tabline#buffers_label = ''

" make it easier to constantly track open buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'short_path'

" default is "|" which causes tabs to shuffle width
let g:airline#extensions#tabline#left_alt_sep = ''

" make it easier to navigate between far away tabs
" mappings based on the plugin doc suggestions
let g:airline#extensions#tabline#buffer_idx_mode = 1

for i in range(0, 9)
  execute 'noremap <leader>'.i '<Plug>AirlineSelectTab'.i
endfor

noremap <leader>- <Plug>AirlineSelectPrevTab
noremap <leader>= <Plug>AirlineSelectNextTab

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" nerdcommenter
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" add indentation within comments, not before them
" works / avoids fighting with Python's black linter
let NERDDefaultAlign = 'left'
