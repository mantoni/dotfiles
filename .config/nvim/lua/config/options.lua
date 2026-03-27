-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false
vim.opt.colorcolumn = "81"
-- Do not hide stuff in markdown
vim.opt.conceallevel = 0
vim.opt.wrap = false

vim.env.ESLINT_D_PPID = vim.fn.getpid()

-- vim.g.sonokai_style = "atlantis"
vim.g.sonokai_enable_italic = true
vim.g.sonokai_float_style = "dim"

-- Remove noise from lualine
vim.g.trouble_lualine = false

vim.g.lazyvim_prettier_needs_config = true

vim.g.root_spec = { "cwd" }

vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
})
vim.g.copilot_no_tab_map = true
