-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.o.updatetime = 1000
vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]])

local function diagnostics_filter(diagnostic)
  -- Add logic to filter specific diagnostics
  local unwanted_messages = {
    "File is a CommonJS module; it may be converted to an ES module.",
  }
  for _, message in ipairs(unwanted_messages) do
    if diagnostic.message:find(message, 1, true) then
      return false
    end
  end
  return true
end

local diagnostics_set = vim.diagnostic.set
vim.diagnostic.set = function(namespace, bufnr, diagnostics, opts)
  local filtered = {}
  for _, diagnostic in ipairs(diagnostics) do
    if diagnostics_filter(diagnostic) then
      table.insert(filtered, diagnostic)
    end
  end
  diagnostics_set(namespace, bufnr, filtered, opts)
end
