return {
    -- Mason
    {
        "mason-org/mason.nvim",
        opts = {
            max_concurrent_installers = 24,
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },

    -- Mason LSP config
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = { "mason-org/mason.nvim" },
        opts = {
            ensure_installed = {
                "clangd",
                "gopls",
                "lua_ls",
                "ruff",
                "ts_ls",
                "marksman",
                "taplo",
            },
            automatic_installation = true,
        },
        config = function(_, opts)
            require("mason-lspconfig").setup(opts)

            -- Load LSP server configs
            local servers = require("lsp.servers")

            -- Remove default LSP keymaps
            vim.keymap.del("n", "grn")
            vim.keymap.del("n", "gra")
            vim.keymap.del("n", "grr")
            vim.keymap.del("n", "gri")
            vim.keymap.del("n", "gO")

            -- Create keymapping on LSP attach
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local keymap = vim.keymap
                    local lsp = vim.lsp
                    local bufopts = { noremap = true, silent = true }

                    keymap.set("n", "gr", lsp.buf.references, bufopts)
                    keymap.set("n", "gd", lsp.buf.definition, bufopts)
                    keymap.set("n", "gi", lsp.buf.implementation, bufopts)
                    keymap.set("n", "ca", lsp.buf.code_action, bufopts)
                    keymap.set("n", "<space>rn", lsp.buf.rename, bufopts)
                    keymap.set("n", "K", lsp.buf.hover, bufopts)
                    keymap.set("n", "<leader>f", function()
                        require("conform").format({ async = true })
                    end, bufopts)
                end,
            })

            -- Enable LSP servers
            vim.lsp.enable(servers.server_list)
        end,
    },

    -- Conform (formatting)
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                rust = { "rustfmt", lsp_format = "fallback" },
                c = { "clang-format" },
                cpp = { "clang-format" },
                cmake = { "gersemi" },
                proto = { "buf" },
                toml = { "taplo" },
                python = function(bufnr)
                    if require("conform").get_formatter_info("ruff_format", bufnr).available then
                        return { "ruff_format" }
                    else
                        return { "black" }
                    end
                end,
            },
        },
    },

    -- Trouble diagnostics
    {
        "folke/trouble.nvim",
        opts = {
            auto_preview = true,
        },
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },

    -- Go.nvim
    {
        "ray-x/go.nvim",
        dependencies = {
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {},
        config = function(_, opts)
            require("go").setup(opts)
            local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.go",
                callback = function()
                    require("go.format").goimports()
                end,
                group = format_sync_grp,
            })
        end,
        event = { "CmdlineEnter" },
        ft = { "go", "gomod" },
        build = ':lua require("go.install").update_all_sync()',
    },
}
