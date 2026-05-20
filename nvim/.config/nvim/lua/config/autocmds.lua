-- Auto-create dir when saving a file
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    callback = function(event)
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end
})

-- Format on save (optional - uncomment if desired)
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        require("conform").format({ async = false, lsp_fallback = true })
    end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ timeout = 200 })
    end,
})

-- Go specific settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = "go",
    callback = function()
        vim.opt_local.expandtab = false
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
    end,
})

-- Go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(event)
        local exclude = { "gitcommit" }
        local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
        local lcount = vim.api.nvim_buf_line_count(event.buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end
})
