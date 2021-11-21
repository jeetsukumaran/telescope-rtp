# telescope-rtp.nvim

Bring the full power of [Telescope](https://github.com/nvim-telescope/telescope.nvim) to your [Neovim](https://neovim.io/) installation's [runtime path](https://neovim.io/doc/user/options.html#'runtimepath')!

This plugin provides TWO [Telescope](https://github.com/nvim-telescope/telescope.nvim) extensions:
-   **`vim_rtp`**: for general searching across each of the directories in your Vim [runtimepath](https://neovim.io/doc/user/options.html#'runtimepath').
-   **`vim_docs`**: for searching specifically in the "`/doc`" subdirectories of each one of the directories in your Vim [runtimepath](https://neovim.io/doc/user/options.html#'runtimepath').

You can restrict the filetypes by specifying a "`-t`" flag in your query (e.g., "`-tlua`" to restrict the search to just "lua" files).
This is probably the most useful with `vim_rtp` as the results here will span multiple file types, whereas with `vim_docs` you are typically only going to get Vim help/doc text files.

## Requirements

- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) (required)

## Install

You can install the extension by cloning this repository somewhere on your filepath, and then adding the following somewhere after your `require('telescope').setup()` call in your configuration file (`init.vim` or `init.lua`) :

```lua
require('telescope').load_extension('vim_rtp')
require('telescope').load_extension('vim_docs')
```
## Setup

### Commands

```vim
:Telescope vim_rtp
:Telescope vim_docs
```

### Bind to Keys:

```vim
nnoremap <M-f>r <cmd>Telescope vim_rtp<cr>
nnoremap <M-f>d <cmd>Telescope vim_docs<cr>
```

### Available Functions

```lua
require'telescope'.extensions.vim_rtp.vim_rtp{}
require'telescope'.extensions.vim_docs.vim_docs{}
```
