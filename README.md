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

### coc.nvim

This may require a manual build:

    (cd ~/.vim/bundle/coc.nvim && npm ci)

Adjust the settings e.g.

    echo '
    {
      "suggest.snippetsSupport": false,  // less completion clutter
      "suggest.maxCompleteItemCount": 10,  // smaller completion
      "diagnostic.enable": false,  // disable syntax error popups
      "suggest.enableFloat": false,  // disable docs in completion
    }
    ' > ~/.vim/coc-settings.json

Finally, install any extensions:

    :CocInstall coc-jedi

### ultisnips

Add any existing snippets in `~/.snippets`.

Extend to other directories like this:

    let g:UltiSnipsSnippetDirectories = g:UltiSnipsSnippetDirectories +
    \  [$HOME.'/somewhere/else']

## Features

See "plugins" in [vimrc](vimrc) for which plugins are used and why.

As well as a few general key mappings (see "mappings" in [vimrc](vimrc)), many plugins also have additional or altered key mappings: see the relevant section for the plugin in [vimrc](vimrc).

### Key mappings

Each key mapping defined in [vimrc](vimrc) follows the rules below:

1. In the first instance, the mapping should be `<leader>` followed by a single key.

2. If there are several related mappings, the "primary" mapping should follow the above rule; other mappings should be `,` followed by the "primary" mapping key, followed by another key.

The first rule ensures common mappings are convenient. The second rule allows for extension, but without reducing the available keys to use with the first rule, or creating ambiguity that slows the "primary" mapping e.g. compare `<leader>f` ("primary") with `<leader>fg` (slows primary) vs `,fg` (primary still fast).
