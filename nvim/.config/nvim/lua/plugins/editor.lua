return {
  -- Telescope fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      local kind_filter = {
        default = {
          "Class",
          "Constructor",
          "Enum",
          "Field",
          "Function",
          "Interface",
          "Method",
          "Module",
          "Namespace",
          "Package",
          "Property",
          "Struct",
          "Trait",
        },
        markdown = false,
        help = false,
        lua = {
          "Class",
          "Constructor",
          "Enum",
          "Field",
          "Function",
          "Interface",
          "Method",
          "Module",
          "Namespace",
          "Property",
          "Struct",
          "Trait",
        },
      }

      local function get_kind_filter(buf)
        buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
        local ft = vim.bo[buf].filetype
        if kind_filter == false then
          return
        end
        if kind_filter[ft] == false then
          return
        end
        if type(kind_filter[ft]) == "table" then
          return kind_filter[ft]
        end
        return type(kind_filter) == "table" and type(kind_filter.default) == "table" and kind_filter.default or nil
      end

      vim.keymap.set("n", "<leader>fR", builtin.resume, { desc = "Telescope resume" })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
      vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "Telescope find references" })

      vim.keymap.set("n", "<leader>ss", function()
        builtin.lsp_document_symbols({
          symbols = get_kind_filter(),
        })
      end, { desc = "Go to symbol" })

      vim.keymap.set("n", "<leader>sS", function()
        builtin.lsp_dynamic_workspace_symbols({
          symbols = get_kind_filter(),
        })
      end, { desc = "Go to symbol (workspace)" })

      require("telescope").load_extension("fzf")
    end,
  },

  -- Telescope FZF native
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },

  -- Neo-tree file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    lazy = false,
    opts = {
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        use_libuv_file_watcher = false,
      },
    },
  },

  -- Flash.nvim for enhanced navigation
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    opts = {
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
    },
  },

  -- Git fugitive
  {
    "tpope/vim-fugitive",
  },
}
