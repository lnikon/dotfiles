return {
    -- Colorscheme
    -- {
    -- 	"folke/tokyonight.nvim",
    -- 	lazy = false,
    -- 	priority = 1000,
    -- 	config = function()
    -- 		vim.cmd.colorscheme("tokyonight")
    -- 	end,
    -- },

    -- {
    --     "rebelot/kanagawa.nvim",
    --     lazy = false,
    --     config = function()
    --         vim.cmd("colorscheme kanagawa-dragon")
    --     end,
    -- },

    {
        'felipefdl/warm-burnout',
        priority = 1000,
        config = function(plugin)
            vim.opt.rtp:append(plugin.dir .. '/nvim')
            vim.cmd.colorscheme 'warm-burnout-dark'
        end,
    },

    -- Icons
    {
        "nvim-mini/mini.icons",
        opts = {},
        version = "*",
    },

    -- Statusline
    {
        "nvim-mini/mini.statusline",
        opts = {},
        version = "*",
    },
}
