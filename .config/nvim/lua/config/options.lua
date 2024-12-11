-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false
vim.opt.colorcolumn = "81"
vim.opt.conceallevel = 0

vim.env.ESLINT_D_PPID = vim.fn.getpid()

vim.g.sonokai_style = "atlantis"
vim.g.sonokai_enable_italic = true
vim.g.sonokai_float_style = "dim"

-- Remove noise from lualine
vim.g.trouble_lualine = false

-- Do not hide stuff in markdown
vim.g.conceallevel = 0

vim.g.lazyvim_prettier_needs_config = true

vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("custom_highlights_sonokai", {}),
  pattern = "sonokai",
  callback = function()
    local config = vim.fn["sonokai#get_configuration"]()
    local palette = vim.fn["sonokai#get_palette"](config.style, config.colors_override)
    local set_hl = vim.fn["sonokai#highlight"]

    -- Reduce search bling
    set_hl("Search", palette.none, palette.bg2)
    set_hl("IncSearch", palette.none, palette.bg2)
    -- Copilot suggestions
    set_hl("CopilotSuggestion", palette.blue, palette.diff_blue)
  end,
})

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--   signs = {
--     severity_limit = "Warning",
--   },
--   underline = {
--     severity_limit = "Warning",
--   },
-- })
