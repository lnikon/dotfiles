local gh = function(repo)
    return "https://github.com/" .. repo
end

vim.pack.add({
    gh("nvim-lua/plenary.nvim"),
    gh("nvim-telescope/telescope.nvim"),
    gh("stevearc/oil.nvim"),
    gh("lewis6991/gitsigns.nvim"),
    gh("sindrets/diffview.nvim"),
    gh("NeogitOrg/neogit"),
    gh("nvim-treesitter/nvim-treesitter"),
    gh("felipefdl/warm-burnout"),
}, { load = true })

-- warm-burnout ships its colorscheme files under an `nvim/` subdirectory
local warm_burnout = vim.pack.get({ "warm-burnout" })[1]
vim.opt.rtp:append(warm_burnout.path .. "/nvim")
vim.cmd.colorscheme("warm-burnout-dark")

require("nvim-treesitter").install({ "c", "cpp", "lua", "cmake" })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "lua", "cmake" },
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

require("oil").setup({
    keymaps = {
        ["q"] = "actions.close",
    },
})

require("gitsigns").setup({
    signs = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
    },
    signs_staged = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
    },
    signs_staged_enable = true,
    signcolumn = true,
    current_line_blame = false,
})

require("neogit").setup()

require("telescope").setup()
