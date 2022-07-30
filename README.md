# vimrc

A minimal config for Vim.

## Prerequisites

You will need the following.

  - [Vundle](https://github.com/VundleVim/Vundle.vim) to manage plugins
  - [ripgrep](https://github.com/BurntSushi/ripgrep#installation) for fzf.vim
  - ctags for Tagbar (install with e.g. Homebrew)
  - [bat](https://github.com/sharkdp/bat) for fzf.vim (optional)

## Install

Run the following to get started.

    git clone https://github.com/benthorner/vim-rc.git $HOME/.vim-rc

Then add the following to ''.vimrc''.

    source $HOME/.vim-rc/vimrc

Finally, open vim and run this...

    :PluginInstall

## Features

The following plugins are used.

   - **vim-abolish** for advance find/replace
   - **nerdtree** to view directory tree
   - **vim-airline** for a better prompt
   - **fzf[.vim]** for finding files and their contents
   - **bufexplorer** to switch files
   - **molokai** for a better color scheme
   - **nerdcommenter** for toggling comments
   - **vim-better-whitespace** for trailing whitespace
   - **vim-fugitive** to browse Git/Hub
   - **tagbar** to browse ctags in a file on-the-fly
   - **supertab** to reduce typing for Vim autocomplete

Key bindings help with the above.

   - `<,> m` toggles NERDTree
   - `<,> f` opens file finder
   - `<,> g` opens file + contents finder
   - `<,> <.>` opens bufexplorer
   - `<,> <,>` switches to previous file
   - `<,> c <space>` toggles comments for current line(s)
   - `<,> b` browses to the Git URL for the file / line(s)
   - `<,> ww` toggles between viewports
   - `<,> wq` closes the current buffer e.g. quickfix list
   - `<c-a><c-q>` dumps fzf results into quickfix list
   - `<,> t` toggles tagbar
