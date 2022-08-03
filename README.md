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

See "plugins" in [vimrc](vimrc) for which plugins are used and why.

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
