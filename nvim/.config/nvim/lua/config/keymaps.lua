local MiniPairs = require('mini.pairs')
local cgu = vim.api.nvim_replace_termcodes('<C-g>u', true, true, true)

local opts = {
    noremap = true,
    silent = true,
}

-----------------
-- Normal mode --
-----------------

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize +2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-----------------
-- Visual mode --
-----------------

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-----------------
-- Neo-tree --
-----------------
vim.keymap.set("n", "<C-\\>", "<cmd>Neotree focus reveal reveal_force_cwd<CR>", opts)
vim.keymap.set("n", "<leader>b", "<cmd>Neotree toggle show buffers right<CR>", opts)
vim.keymap.set("n", "<leader>s", "<cmd>Neotree float git_status<CR>", opts)

-----------------
-- Add undo break-points --
-----------------
-- local function undo_open(pair, neigh)
--     return function()
--         local keys = MiniPairs.open(pair, neigh)
--         vim.api.nvim_feedkeys(cgu, 'n', true)
--         return keys
--     end
-- end
--
--
-- local function undo_close(pair, neigh)
--     return function()
--         local keys = MiniPairs.close(pair, neigh)
--         vim.api.nvim_feedkeys(cgu, 'n', true)
--         return keys
--     end
-- end

vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- local minipairs_opts = { expr = true, replace_keycodes = false }
-- vim.keymap.set("i", "(", undo_open('()', '[^\\].'), minipairs_opts)
-- vim.keymap.set("i", ")", undo_close('()', '[^\\].'), minipairs_opts)
-- vim.keymap.set("i", "{", "{<c-g>u")
-- vim.keymap.set("i", "}", "}<c-g>u")
-- vim.keymap.set("i", "\'", "\'<c-g>u")
-- vim.keymap.set("i", "\"", "\"<c-g>u")
-- vim.keymap.set("i", " ", " <c-g>u")
