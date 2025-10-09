return {
    "mason-org/mason-lspconfig.nvim",
    enable = true,
    opts = {
        ensure_installed = {
            "clangd",
            "gopls",
            "bashls",
            "neocmake",
            "buf_ls",
            "docker_language_server",
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
