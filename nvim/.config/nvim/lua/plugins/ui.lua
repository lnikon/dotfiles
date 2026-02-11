return {
  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight")
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
