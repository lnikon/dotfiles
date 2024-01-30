vim.g.mapleader = " "

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>an", ":lua require('neogen').generate()<CR>", opts)
