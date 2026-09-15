local opts = {
    noremap = true,
    silent = true,
}

-----------------
-- Window nav  --
-----------------
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

vim.keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":vertical resize +2<CR>", opts)
vim.keymap.set("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-----------------
-- Visual mode --
-----------------
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-----------------
-- Insert mode undo break-points --
-----------------
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-----------------
-- Completion menu --
-----------------
-- 'completeopt' has "noselect", so nothing is chosen until you move onto an item.
-- <CR> only accepts once something is selected, otherwise it stays a newline.
-- vim.keymap.set("i", "<Tab>", function()
--     return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
-- end, { expr = true, desc = "Next completion item" })
-- vim.keymap.set("i", "<S-Tab>", function()
--     return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
-- end, { expr = true, desc = "Previous completion item" })
-- vim.keymap.set("i", "<CR>", function()
--     return vim.fn.complete_info({ "selected" }).selected ~= -1 and "<C-y>" or "<CR>"
-- end, { expr = true, desc = "Accept selected completion" })

-----------------
-- File manager (oil.nvim) --
-----------------
vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open parent directory" })

-----------------
-- Telescope --
-----------------
vim.keymap.set("n", "<leader>ff", function()
    require("telescope.builtin").find_files()
end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", function()
    require("telescope.builtin").live_grep()
end, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", function()
    require("telescope.builtin").buffers()
end, { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fs", function()
    require("telescope.builtin").lsp_document_symbols()
end, { desc = "List document symbols" })
vim.keymap.set("n", "<leader>ps", function()
    require("telescope.goto_anything").project_symbols()
end, { desc = "List project-scoped workspace symbols" })
vim.keymap.set("n", "<C-p>", function()
    require("telescope.goto_anything").open()
end, { desc = "Goto anything (files / @buffer symbols / #project symbols)" })
vim.keymap.set("n", "<leader>h", ":LspClangdSwitchSourceHeader<CR>")

-----------------
-- Git (Neogit + gitsigns) --
-----------------
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Neogit" })
vim.keymap.set("n", "]c", function()
    require("gitsigns").nav_hunk("next")
end, { desc = "Next git hunk" })
vim.keymap.set("n", "[c", function()
    require("gitsigns").nav_hunk("prev")
end, { desc = "Previous git hunk" })
vim.keymap.set("n", "<leader>hs", function()
    require("gitsigns").stage_hunk()
end, { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>hr", function()
    require("gitsigns").reset_hunk()
end, { desc = "Reset hunk" })

-----------------
-- Sessions (persistence.nvim) --
-----------------
vim.keymap.set("n", "<leader>qs", function()
    require("persistence").load()
end, { desc = "Restore session for this directory" })
vim.keymap.set("n", "<leader>ql", function()
    require("persistence").load({ last = true })
end, { desc = "Restore last session" })
vim.keymap.set("n", "<leader>qS", function()
    require("persistence").select()
end, { desc = "Select a session to restore" })
vim.keymap.set("n", "<leader>qd", function()
    require("persistence").stop()
end, { desc = "Stop saving the current session" })

-----------------
-- Diagnostics / formatting --
-----------------
vim.keymap.set("n", "<leader>xx", vim.diagnostic.setloclist, { desc = "Buffer diagnostics" })
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer" })
vim.keymap.set("n", "ca", require("vim.lsp.buf").code_action, bufopts)

-----------------
-- Project-scoped jumps --
-----------------
local project = require("util.project")

-- Repeat `key` until the jump lands inside the project; rewind with `back` if it never does.
local function scoped_jump(key, back)
    local jump, rewind = vim.keycode(key), vim.keycode(back)
    -- "n" so we don't recurse into these very mappings, "x" to run it before we look at the result
    local function feed(keys)
        vim.api.nvim_feedkeys(keys, "nx", false)
    end
    return function()
        local root = project.root()
        if not root then
            feed(jump:rep(vim.v.count1))
            return
        end
        for _ = 1, vim.v.count1 do
            local steps = 0
            repeat
                local idx = vim.fn.getjumplist()[2]
                feed(jump)
                if vim.fn.getjumplist()[2] == idx then -- end of the jumplist
                    if steps > 0 then
                        feed(rewind:rep(steps))
                    end
                    return
                end
                steps = steps + 1
            until project.contains(root, vim.api.nvim_buf_get_name(0))
        end
    end
end

vim.keymap.set("n", "<C-o>", scoped_jump("<C-o>", "<C-i>"), { desc = "Jump back (project-scoped)" })
vim.keymap.set("n", "<C-i>", scoped_jump("<C-i>", "<C-o>"), { desc = "Jump forward (project-scoped)" })

vim.keymap.set({ "x", "o" }, "af", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "if", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ac", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end)
vim.keymap.set({ "x", "o" }, "ic", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end)
