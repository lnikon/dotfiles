local M = {}

-- .git wins; otherwise the outermost directory of a chain of CMakeLists.txt
function M.root()
    local file = vim.api.nvim_buf_get_name(0)
    if file == "" then
        return nil
    end
    local git = vim.fs.root(file, ".git")
    if git then
        return vim.fs.normalize(git)
    end
    local cmake = vim.fs.find("CMakeLists.txt", { path = vim.fs.dirname(file), upward = true, limit = math.huge })
    local outermost = cmake[#cmake]
    return outermost and vim.fs.normalize(vim.fs.dirname(outermost))
end

function M.contains(root, file)
    return file ~= "" and vim.startswith(vim.fs.normalize(file), root .. "/")
end

return M
