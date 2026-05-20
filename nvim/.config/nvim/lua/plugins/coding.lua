return {
    -- Completion
    {
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "1.*",
        opts = {
            keymap = { preset = "default" },
            appearance = {
                nerd_font_variant = "mono",
            },
            completion = { documentation = { auto_show = false } },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },

    -- Comment
    {
        "nvim-mini/mini.comment",
        opts = {},
        version = "*",
    },

    -- Auto-pairs
    {
        "nvim-mini/mini.pairs",
        opts = {},
        version = "*",
    },

    -- Indent scope
    {
        "nvim-mini/mini.indentscope",
        opts = {},
        version = "*",
    },

    -- Buffer remove (preserves window layout)
    {
        "nvim-mini/mini.bufremove",
        opts = {},
        version = "*",
        keys = {
            {
                "<leader>bd",
                function()
                    require("mini.bufremove").delete()
                end,
                desc = "Delete buffer",
            },
        },
    },
}
