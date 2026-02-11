return {
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c",
          "cpp",
          "proto",
          "cmake",
          "python",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "markdown",
          "markdown_inline",
          "go",
          "rust",
          "javascript",
          "typescript",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              -- Functions
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              -- Classes
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              -- Parameters/arguments
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              -- Conditionals
              ["ai"] = "@conditional.outer",
              ["ii"] = "@conditional.inner",
              -- Loops
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              -- Comments
              ["aC"] = "@comment.outer",
            },
          },
        },
      })
    end,
  },

  -- Treesitter context
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {},
  },
}
