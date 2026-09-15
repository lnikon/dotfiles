-- Sublime/VSCode-style "Goto Anything": <C-p> opens a file finder; typing "@"
-- switches to symbols in the current buffer, "#" to symbols across the project.
local M = {}

local project = require("util.project")

---@param line string
---@return "files"|"buffer_symbols"|"project_symbols" mode
---@return string rest text after the mode prefix, carried into the next picker
local function classify(line)
    local prefix = line:sub(1, 1)
    if prefix == "@" then
        return "buffer_symbols", line:sub(2)
    elseif prefix == "#" then
        return "project_symbols", line:sub(2)
    end
    return "files", line
end

-- workspace/symbol only takes a plain string query, so "Container::name" (which
-- doesn't mean anything to the server) is reduced to "name" for the request; the
-- full "Container::name" text is then matched client-side against entries built
-- with the container listed first, so the query's character order lines up with it.
local function open_project_symbols(default_text)
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local entry_display = require("telescope.pickers.entry_display")
    local channel = require("plenary.async.control").channel

    local root = project.root() or vim.uv.cwd()
    local bufnr = vim.api.nvim_get_current_buf()

    local cancel_previous = function() end

    local function requester(prompt)
        local query = prompt:match("::([^:]*)$") or prompt

        local tx, rx = channel.oneshot()
        cancel_previous()
        cancel_previous = vim.lsp.buf_request_all(bufnr, "workspace/symbol", { query = query }, tx)

        local by_client = rx() ---@type table<integer, {error: lsp.ResponseError?, result: lsp.WorkspaceSymbol[]?}>
        local items = {}
        for client_id, client_res in pairs(by_client) do
            if client_res.result then
                local client = vim.lsp.get_client_by_id(client_id)
                local client_items = vim.lsp.util.symbols_to_items(client_res.result, bufnr, client.offset_encoding)
                for i, item in ipairs(client_items) do
                    item.name = client_res.result[i].name
                    item.container = client_res.result[i].containerName
                end
                vim.list_extend(items, client_items)
            end
        end

        return vim.tbl_filter(function(item)
            return project.contains(root, item.filename)
        end, items)
    end

    local displayer = entry_display.create({
        separator = "  ",
        items = { { width = 40 }, { remaining = true } },
    })

    local function entry_maker(item)
        local qualified = item.container and (item.container .. "::" .. item.name) or item.name
        return {
            value = item,
            ordinal = qualified,
            display = function()
                return displayer({ qualified, ("%s  %s:%d"):format(item.kind, item.filename:sub(#root + 2), item.lnum) })
            end,
            filename = item.filename,
            lnum = item.lnum,
            col = item.col,
        }
    end

    pickers
        .new({}, {
            prompt_title = "Project Symbols",
            default_text = default_text,
            finder = finders.new_dynamic({ fn = requester, entry_maker = entry_maker }),
            previewer = conf.qflist_previewer({}),
            sorter = conf.generic_sorter({}),
        })
        :find()
end

local open

-- Uses nvim_buf_attach/on_lines (what Telescope's own prompt reactivity is built
-- on) rather than TextChangedI/TextChangedP: those fire twice per keystroke here
-- (once per event) and would schedule the mode switch twice, opening the target
-- picker two times over.
local function attach_watcher(prompt_bufnr, mode)
    vim.api.nvim_buf_attach(prompt_bufnr, false, {
        on_lines = function()
            if not vim.api.nvim_buf_is_valid(prompt_bufnr) then
                return true
            end
            local ok, line = pcall(require("telescope.actions.state").get_current_line)
            if not ok then
                return
            end
            local next_mode, rest = classify(line)
            if next_mode == mode then
                return
            end
            vim.schedule(function()
                if vim.api.nvim_buf_is_valid(prompt_bufnr) then
                    require("telescope.actions").close(prompt_bufnr)
                end
                open(next_mode, rest)
            end)
            return true -- detach; the replacement buffer gets its own watcher
        end,
    })
end

-- Some pickers (e.g. lsp_document_symbols) only create their prompt buffer
-- once their LSP request resolves, so it doesn't exist yet when the opening
-- call below returns. Watching for the buffer's filetype instead of reading
-- the "current buffer" right after the call catches it whenever it actually
-- appears, sync or async.
local pending_mode = nil

vim.api.nvim_create_autocmd("FileType", {
    pattern = "TelescopePrompt",
    callback = function(args)
        if pending_mode then
            attach_watcher(args.buf, pending_mode)
            pending_mode = nil
        end
    end,
})

open = function(mode, default_text)
    pending_mode = mode
    if mode == "files" then
        require("telescope.builtin").find_files({ cwd = project.root(), default_text = default_text })
    elseif mode == "buffer_symbols" then
        require("telescope.builtin").lsp_document_symbols({ default_text = default_text })
    else
        open_project_symbols(default_text)
    end
end

function M.open()
    open("files", "")
end

function M.project_symbols()
    open("project_symbols", "")
end

return M
