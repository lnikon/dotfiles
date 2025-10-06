return {
    "mason-org/mason-lspconfig.nvim",
    enable = true,
    opts = {
        ensure_installed = {
            "clangd",
            "gopls",
            "bash_ls",
            "cmake_ls",
            "buf_ls",
            "docker-language-server",
            "lua_ls",
            "marksman",
            "ruff",
            "tombi",
            "ts_ls",
            "yamlls",
            "zls",
            "rust_analyzer"
        }
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
