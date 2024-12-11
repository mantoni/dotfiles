-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- vim.o.updatetime = 500
vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]])
