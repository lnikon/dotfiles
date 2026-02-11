# Neovim Configuration

Modern, streamlined Neovim configuration with 12 files and ~930 lines.

## Structure

```
~/.config/nvim/
├── init.lua                    # Bootstrap
├── lua/
│   ├── config/
│   │   ├── options.lua         # Vim options
│   │   ├── keymaps.lua         # Core keymaps
│   │   ├── autocmds.lua        # Autocommands
│   │   └── lazy.lua            # Lazy.nvim setup
│   ├── plugins/
│   │   ├── ui.lua              # Colorscheme, statusline, icons
│   │   ├── editor.lua          # Telescope, neo-tree, git, flash
│   │   ├── coding.lua          # Completion, pairs, comments
│   │   ├── lsp.lua             # LSP, mason, conform, trouble
│   │   ├── treesitter.lua      # Treesitter config
│   │   └── debug.lua           # DAP debugging
│   └── lsp/
│       └── servers.lua         # LSP server configs
└── README.md                   # This file
```

## Plugins (25 total)

### Core (3)
- **lazy.nvim** - Plugin manager
- **plenary.nvim** - Lua utilities
- **nui.nvim** - UI components

### UI (4)
- **tokyonight.nvim** - Colorscheme
- **mini.icons** - Icon support
- **mini.statusline** - Statusline
- **neo-tree.nvim** - File explorer

### Navigation (3)
- **telescope.nvim** - Fuzzy finder
- **telescope-fzf-native.nvim** - FZF sorter
- **flash.nvim** - Enhanced motion

### Editor (4)
- **mini.comment** - Commenting
- **mini.pairs** - Auto-pairs
- **mini.indentscope** - Indent guides
- **gitsigns.nvim** - Git signs in gutter

### Completion (2)
- **blink.cmp** - Completion engine
- **friendly-snippets** - Snippet collection

### LSP (4)
- **mason.nvim** - LSP installer
- **mason-lspconfig.nvim** - Mason integration
- **conform.nvim** - Formatting
- **trouble.nvim** - Diagnostics UI

### Git (1)
- **vim-fugitive** - Git integration

### Language (1)
- **go.nvim** - Go-specific tooling

### Debug (3)
- **nvim-dap** - Debug adapter protocol
- **nvim-dap-ui** - DAP UI
- **nvim-nio** - Async I/O (DAP dependency)

### Utilities (1)
- **mini.bufremove** - Safe buffer deletion

## Key Mappings

### Leader Keys
- Leader: `,`
- Local leader: `\`

### Window Navigation
- `<C-h>` - Move to left window
- `<C-j>` - Move to down window
- `<C-k>` - Move to up window
- `<C-l>` - Move to right window

### Window Resize
- `<C-Up>` - Decrease height
- `<C-Down>` - Increase height
- `<C-Left>` - Increase width
- `<C-Right>` - Decrease width

### File Explorer (Neo-tree)
- `<C-\>` - Toggle file tree
- `<leader>b` - Toggle buffer list
- `<leader>s` - Show git status

### Telescope
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>fr` - Find references
- `<leader>fR` - Resume last search
- `<leader>ss` - Document symbols
- `<leader>sS` - Workspace symbols

### Flash.nvim (Motion)
- `s` - Jump to location
- `S` - Treesitter selection
- `r` - Remote flash (operator mode)
- `R` - Treesitter search

### LSP
- `gd` - Go to definition
- `gr` - Go to references
- `gi` - Go to implementation
- `K` - Hover documentation
- `ca` - Code action
- `<space>rn` - Rename symbol
- `<leader>f` - Format buffer

### Clangd Specific
- `:LspClangdSwitchSourceHeader` - Switch between .h and .cpp

### Trouble (Diagnostics)
- `<leader>xx` - Toggle diagnostics
- `<leader>xX` - Buffer diagnostics
- `<leader>cs` - Symbols
- `<leader>cl` - LSP definitions/references
- `<leader>xL` - Location list
- `<leader>xQ` - Quickfix list

### DAP (Debugging)
- `<leader>db` - Toggle breakpoint
- `<leader>dc` - Continue
- `<leader>di` - Step into
- `<leader>do` - Step over
- `<leader>dO` - Step out
- `<leader>dr` - Open REPL
- `<leader>dl` - Run last
- `<leader>du` - Toggle DAP UI

### Editing
- `gcc` - Comment/uncomment line
- `gc` - Comment/uncomment selection (visual mode)
- `<leader>bd` - Delete buffer (preserves layout)
- `<` / `>` - Indent left/right (stays in visual mode)

### Go Specific
- `:GoTest` - Run tests
- `:GoTestFunc` - Test current function
- Auto-format with goimports on save

## LSP Servers

The following LSP servers are configured and auto-installed via Mason:

- **clangd** - C/C++/CUDA (with source/header switching)
- **gopls** - Go (with GOMODCACHE handling)
- **lua_ls** - Lua (Neovim runtime configured)
- **ruff** - Python (linting + formatting)
- **ts_ls** - TypeScript/JavaScript
- **yaml_ls** - YAML
- **bash_ls** - Bash
- **cmake_ls** - CMake
- **marksman** - Markdown
- **taplo** - TOML
- **buf_ls** - Protocol Buffers
- **docker_language_server** - Docker

## Formatters

Configured via conform.nvim:

- **Lua**: stylua
- **Rust**: rustfmt
- **C/C++**: clang-format
- **Python**: ruff_format (fallback: black)
- **CMake**: gersemi
- **Proto**: buf
- **TOML**: taplo
- **Go**: goimports (via go.nvim)

## DAP Debuggers

Debugging support for:

- **Go**: delve (dlv)
- **Python**: debugpy
- **C/C++**: lldb-dap

## Installation

1. Make sure you have Neovim 0.11+ installed
2. Clone this config or symlink it to `~/.config/nvim`
3. Start Neovim - Lazy.nvim will automatically install
4. Run `:Lazy sync` to install all plugins
5. Run `:Mason` to verify LSP server installation
6. Install debuggers manually:
   - Go: `go install github.com/go-delve/delve/cmd/dlv@latest`
   - Python: `pip install debugpy`
   - C/C++: Install lldb-dap (usually in LLVM package)

## Requirements

- Neovim >= 0.11
- Git
- Ripgrep (for Telescope grep)
- fd or find (for Telescope file finding)
- A Nerd Font for icons
- gcc/make (for telescope-fzf-native)
- Language-specific tools:
  - Go: go toolchain
  - Python: python3
  - C/C++: clang/clangd
  - Node.js: for TypeScript

## Tips

- Use `:checkhealth` to verify your setup
- Use `:Lazy` to manage plugins
- Use `:Mason` to manage LSP servers/formatters
- Format on save is disabled by default (uncomment in `config/autocmds.lua` to enable)
- Use `:h <plugin-name>` for plugin help

## Customization

- **Options**: Edit `lua/config/options.lua`
- **Keymaps**: Edit `lua/config/keymaps.lua`
- **Plugins**: Edit files in `lua/plugins/`
- **LSP servers**: Edit `lua/lsp/servers.lua`
- **Autocommands**: Edit `lua/config/autocmds.lua`
