return {
    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
    },

    -- Treesitter context
    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {},
    },
}
