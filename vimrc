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

" make it easy to switch back to the previously used buffer
noremap <leader><leader> :e#<cr>

" Make editing commands more intuitive (like in term)
cnoremap <c-a> <home>

" Avoid overwriting paste buffer with previous content
xnoremap <silent> p p:let @+=@0<CR>
"
" Make it easy to move single lines to the start of a file.
"
" Note: when we set the return mark we immediately use it to
" ensure the subsequent "m[ove]" moves the current line - if
" the cursor is at the end of the line it actually moves the
" next line, if this "return" technique is not used.
noremap <silent> <leader>1 m1 '1 :lockmarks m 0<CR> '1

" Make it easy to search for a visual selection / line
" https://vim.fandom.com/wiki/Search_for_visually_selected_text
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>

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
Plugin 'embear/vim-localvimrc'                      " per-project configuration
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
let g:bufExplorerDefaultHelp = 0

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" localvimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Allow running vimrc scripts natively when confirmed
" and store this decision per-project.
let g:localvimrc_sandbox = 0
let g:localvimrc_persistent = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" PYTHON
""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Don't show imports as they get auto expanded
" if viewing tags after opening a file.
let g:tagbar_type_python = {
    \ 'kinds' : [
        \ 'c:classes',
        \ 'f:functions',
        \ 'm:members',
        \ 'v:variables',
        \ '?:unknown',
    \ ],
\ }

Plugin 'davidhalter/jedi-vim'
let g:jedi#goto_assignments_command = ""  " release <c-g>
let g:jedi#goto_stubs_command = ""  " release <c-s>
let g:jedi#use_tag_stack = 1  " <c-t> to go back to usages
let g:jedi#popup_on_dot = 0  " disable in favour of coc

" install coc-jedi for coc.nvim autocompletion support
"
" {
"   "jedi.completion.disableSnippets": true
" }

Plugin 'dense-analysis/ale'
let g:ale_linters_explicit = 1  " must specify linters
let g:ale_lint_on_text_changed = 'never'  " only on save
let g:ale_fix_on_save = 1
let g:ale_virtualtext_cursor = 'disabled'  " hint comments

Plugin 'ranelpadon/python-copy-reference.vim'
nnoremap <leader>e :PythonCopyReferencePytest<CR>
nnoremap ,ed :PythonCopyReferenceDotted<CR>
nnoremap ,er :PythonCopyReferenceImport<CR>
