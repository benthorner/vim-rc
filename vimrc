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
"
" quickly prune individual buffers (outside of bufexplorer)
noremap <leader><bs> :bd<cr>

" faster saves (and avoids :W typos, which is used by fzf)
noremap <leader>s :w<cr>

" make it easy to switch back to the  previously used buffer
noremap <leader><leader> :e#<cr>

" Make editing commands more intuitive (like in term)
cnoremap <c-a> <home>

" Avoid overwriting paste buffer with previous content
xnoremap <silent> p p:let @+=@0<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'tpope/vim-abolish'                          " advanced find/replace
Plugin 'scrooloose/nerdtree'                        " to view directory tree
Plugin 'bling/vim-airline'                          " better status / tab lines
Plugin 'junegunn/fzf'                               " required for fzf.vim
Plugin 'junegunn/fzf.vim'                           " finding files and their contents
Plugin 'jlanzarotta/bufexplorer'                    " to manage open buffers
Plugin 'tomasr/molokai'                             " a better color scheme
Plugin 'scrooloose/nerdcommenter'                   " for toggling comments
Plugin 'ntpeters/vim-better-whitespace'             " remove trailing whitespace
Plugin 'tpope/vim-fugitive'                         " required for vim-rhubarb
Plugin 'tpope/vim-rhubarb'                          " to browse Git/Hub for files
Plugin 'preservim/tagbar'                           " to browse file ctags on-the-fly
Plugin 'neoclide/coc.nvim', {'branch': 'release'}   " general autocomplete popup
Plugin 'SirVer/ultisnips'                           " to insert common snippets
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
\  --bind ctrl-w:select-all
\  --history /tmp/fzf-history
\  --color=fg:21,hl:33
\  --color=fg+:13,bg+:-1,hl+:39
\'

command! -bang -nargs=* FzfGrep call fzf#vim#grep(
\  "rg --line-number --no-heading --color=always -- ''",
\  1,
\  fzf#vim#with_preview({'options': ['--exact', <f-args>]}),
\  <bang>0
\)

command! -bang -nargs=* FzfFiles call fzf#run(
\  fzf#wrap(
\    fzf#vim#with_preview({
\      "source": "git ls-files --cached --others --exclude-standard || find . -type f",
\      "options": ["--exact", "--multi"],
\    }),
\    <bang>0
\  )
\)

command! -bang -nargs=* FzfRgCword call fzf#vim#grep(
\   "rg --line-number --no-heading --color=always -- " . shellescape(expand('<cword>')),
\   1,
\   fzf#vim#with_preview({'options': ['--exact', '-q', <q-args>]}),
\   1
\ )


noremap <leader>f :FzfFiles!<cr>
noremap ,fg :FzfGrep!<cr>
noremap ,fc :FzfGrep! --nth=3<CR>
noremap ,fw :FzfRgCword!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" nerdtree
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 60
let g:NERDTreeMinimalMenu = 1

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
hi Visual ctermbg=18
hi QuickFixLine ctermbg=18

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
let g:airline_extensions = []      " minimal opt-in
let g:airline_section_x = ''       " hide file type
let g:airline_section_y = ''       " hide encoding
let g:airline_section_z = '%l/%L'  " just line nums

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" nerdcommenter
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" add indentation within comments, not before them
" works / avoids fighting with Python's black linter
let NERDDefaultAlign = 'left'

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" coc.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use <cr> to confirm selections (tab is confusing)
inoremap <silent><expr> <CR>
\   coc#pum#visible()
\   ? coc#pum#confirm()
\   : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" disable basic word completion for current (around)
" and other buffers - often irrelevant e.g. comments
autocmd Filetype * let b:coc_disabled_sources = [
\   'around',
\   'buffer',
\]

" use purples (13) and blues (39, 33) for suggestions
" on top of a grey background (234, 235)
hi CocMenuSel ctermfg=13 ctermbg=235
hi CocSearch ctermfg=39
hi CocFloating ctermfg=33 ctermbg=234

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" ultisnips
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsSnippetDirectories=[$HOME."/.snippets"]
