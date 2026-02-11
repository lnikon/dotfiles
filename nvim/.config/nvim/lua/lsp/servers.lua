local M = {}

-- List of LSP servers to enable
M.server_list = {
  "clangd",
  "lua_ls",
  "gopls",
  "docker_language_server",
  "ruff",
  "ts_ls",
  "taplo",
  "buf_ls",
  "marksman",
}

-- Clangd configuration
---@brief
--- https://clangd.llvm.org/installation.html
--- https://clangd.llvm.org/extensions.html#switch-between-sourceheader

local function switch_source_header(bufnr, client)
  local method_name = "textDocument/switchSourceHeader"
  ---@diagnostic disable-next-line:param-type-mismatch
  if not client or not client:supports_method(method_name) then
    return vim.notify(
      ("method %s is not supported by any servers active on the current buffer"):format(method_name)
    )
  end
  local params = vim.lsp.util.make_text_document_params(bufnr)
  ---@diagnostic disable-next-line:param-type-mismatch
  client:request(method_name, params, function(err, result)
    if err then
      error(tostring(err))
    end
    if not result then
      vim.notify("corresponding file cannot be determined")
      return
    end
    vim.cmd.edit(vim.uri_to_fname(result))
  end, bufnr)
end

---@class ClangdInitializeResult: lsp.InitializeResult
---@field offsetEncoding? string

---@type vim.lsp.Config
vim.lsp.config.clangd = {
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  root_markers = {
    ".clangd",
    ".clang-tidy",
    ".clang-format",
    "compile_commands.json",
    "compile_flags.txt",
    "configure.ac",
    ".git",
  },
  capabilities = {
    textDocument = {
      completion = {
        editsNearCursor = true,
      },
    },
    offsetEncoding = { "utf-8", "utf-16" },
  },
  ---@param init_result ClangdInitializeResult
  on_init = function(client, init_result)
    if init_result.offsetEncoding then
      client.offset_encoding = init_result.offsetEncoding
    end
  end,
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "LspClangdSwitchSourceHeader", function()
      switch_source_header(bufnr, client)
    end, { desc = "Switch between source/header" })
  end,
}

-- Gopls configuration
---@brief
--- https://github.com/golang/tools/tree/master/gopls
--- Google's lsp server for golang with GOMODCACHE handling

local mod_cache = nil
local std_lib = nil

---@param custom_args {envvar_id: string, custom_subdir: string?}
---@param on_complete fun(dir: string | nil)
local function identify_go_dir(custom_args, on_complete)
  local cmd = { "go", "env", custom_args.envvar_id }
  vim.system(cmd, { text = true }, function(output)
    local res = vim.trim(output.stdout or "")
    if output.code == 0 and res ~= "" then
      if custom_args.custom_subdir and custom_args.custom_subdir ~= "" then
        res = res .. custom_args.custom_subdir
      end
      on_complete(res)
    else
      vim.schedule(function()
        vim.notify(
          ("[gopls] identify " .. custom_args.envvar_id .. " dir cmd failed with code %d: %s\n%s"):format(
            output.code,
            vim.inspect(cmd),
            output.stderr
          )
        )
      end)
      on_complete(nil)
    end
  end)
end

local function get_std_lib_dir()
  if std_lib and std_lib ~= "" then
    return std_lib
  end
  identify_go_dir({ envvar_id = "GOROOT", custom_subdir = "/src" }, function(dir)
    if dir then
      std_lib = dir
    end
  end)
  return std_lib
end

local function get_mod_cache_dir()
  if mod_cache and mod_cache ~= "" then
    return mod_cache
  end
  identify_go_dir({ envvar_id = "GOMODCACHE" }, function(dir)
    if dir then
      mod_cache = dir
    end
  end)
  return mod_cache
end

local function get_root_dir(fname)
  if mod_cache and fname:sub(1, #mod_cache) == mod_cache then
    local clients = vim.lsp.get_clients({ name = "gopls" })
    if #clients > 0 then
      return clients[#clients].config.root_dir
    end
  end
  if std_lib and fname:sub(1, #std_lib) == std_lib then
    local clients = vim.lsp.get_clients({ name = "gopls" })
    if #clients > 0 then
      return clients[#clients].config.root_dir
    end
  end
  return vim.fs.root(fname, "go.work") or vim.fs.root(fname, "go.mod") or vim.fs.root(fname, ".git")
end

---@type vim.lsp.Config
vim.lsp.config.gopls = {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    get_mod_cache_dir()
    get_std_lib_dir()
    on_dir(get_root_dir(fname))
  end,
}

-- Lua_ls configuration
---@type vim.lsp.Config
vim.lsp.config.lua_ls = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    },
  },
}

return M
