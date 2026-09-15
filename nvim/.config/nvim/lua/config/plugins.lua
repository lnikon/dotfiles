local gh = function(repo)
    return "https://github.com/" .. repo
end

vim.pack.add({
    gh("nvim-lua/plenary.nvim"),
    gh("nvim-telescope/telescope.nvim"),
    gh("stevearc/oil.nvim"),
    gh("nvim-mini/mini.files"),
    gh("lewis6991/gitsigns.nvim"),
    gh("sindrets/diffview.nvim"),
    gh("NeogitOrg/neogit"),
    gh("nvim-treesitter/nvim-treesitter"),
    gh("mason-org/mason.nvim"),
    gh("folke/persistence.nvim"),
    gh("rebelot/kanagawa.nvim")
}, { load = true })

vim.cmd.colorscheme("kanagawa")

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

-- Mason prepends its bin directory to PATH, so the `cmd`s in lua/lsp/servers.lua
-- resolve to the servers it installs. Installs run async on first start.
require("mason").setup()

local registry = require("mason-registry")
registry.refresh(function()
    for _, name in ipairs(require("lsp.servers").mason_packages) do
        local pkg = registry.get_package(name)
        if not pkg:is_installed() then
            pkg:install()
        end
    end
end)

require("persistence").setup()
