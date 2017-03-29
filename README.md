# vimrc

A minimal config for Vim.

## Prerequisites

You will need the following.

  - [Vundle](https://github.com/VundleVim/Vundle.vim) to manage plugins
  - [Ack](https://beyondgrep.com/) (optional) to support ack.vim

## Install

Run the following to get started.

    git clone https://github.com/benthorner/vim-rc.git $HOME/.vim-rc

Then add the following to ''.vimrc''.

    source $HOME/.vim-rc/.vimrc

Finally, open vim and run this...

    :PluginInstall

## Features

The following plugins are used.

   - **nerdtree** to view directory tree
   - **vim-airline** for a better prompt
   - **syntastic** for syntax checking
   - **ctrlp.vim** for finding files
   - **bufexplorer** to switch files
   - **molokai** for a better color scheme
   - **ack.vim** for grepping files
   - **nerdcommenter** for toggling comments

Key bindings help with the above.

   - `<space> m` toggles NERDTree
   - `<space> f` opens ctrlp
   - `<,> <.>` opens bufexplorer
   - `<,> <,>` switches to last file
