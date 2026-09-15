vim.lsp.enable(require("lsp.servers").server_list)

-- `autotrigger` only opens the completion menu on the server's own triggerCharacters
-- ("." / "->" / "::" / ...), so a bare identifier never pops one. Adding the identifier
-- characters makes every keystroke re-query the server, which keeps the candidates
-- semantic instead of a stale list filtered client-side. Capabilities are per client,
-- so only extend them once even though LspAttach fires per buffer.
local identifier_triggers_added = {}

local function trigger_on_identifiers(client)
    if identifier_triggers_added[client.id] then
        return
    end
    identifier_triggers_added[client.id] = true

    local provider = client.server_capabilities.completionProvider
    provider.triggerCharacters = provider.triggerCharacters or {}
    for char in ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_"):gmatch(".") do
        table.insert(provider.triggerCharacters, char)
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })

        if client:supports_method("textDocument/completion") then
            trigger_on_identifiers(client)
            vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
        end

        if client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr, async = false })
                end,
            })
        end
    end,
})
