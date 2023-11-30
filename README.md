# lasso.nvim

A Neovim plugin that lets you mark files for easy access, manage a set of terminals, and quickly switch between them. A lightweight [Harpoon](https://github.com/ThePrimeagen/harpoon) alternative.

## Installation

Requires Neovim 0.5.0 or newer. Install with your favorite package manager. For example, in lazy.nvim:

```lua
{ 'niqodea/lasso.nvim' }
```

## Configuration

Below is an `init.lua` snippet to get you started with lasso.nvim:

```lua
require('lasso').setup{
    -- marks_tracker_path = 'custom/path/to/marks/tracker'
}

-- Mark current file
vim.api.nvim_set_keymap('n', vim.g.mapleader..'m', '<cmd>lua require('lasso').mark_file()<cr>', {noremap = true})

-- Go to marks tracker (editable, use `gf` to go to file under cursor)
vim.api.nvim_set_keymap('n', vim.g.mapleader..'M', '<cmd>lua require('lasso').open_marks_tracker()<cr>', {noremap = true})

-- Jump to n-th marked file
vim.api.nvim_set_keymap('n', vim.g.mapleader..'1', '<cmd>lua require('lasso').open_marked_file(1)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'2', '<cmd>lua require('lasso').open_marked_file(2)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'3', '<cmd>lua require('lasso').open_marked_file(3)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'4', '<cmd>lua require('lasso').open_marked_file(4)<cr>', {noremap = true})

-- Create or jump to n-th terminal
vim.api.nvim_set_keymap('n', vim.g.mapleader..'<F1>', '<cmd>lua require('lasso').open_terminal(1)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'<F2>', '<cmd>lua require('lasso').open_terminal(2)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'<F3>', '<cmd>lua require('lasso').open_terminal(3)<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', vim.g.mapleader..'<F4>', '<cmd>lua require('lasso').open_terminal(4)<cr>', {noremap = true})
