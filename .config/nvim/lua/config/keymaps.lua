-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- map `]<space>` and `[<space>` to add space below and above
vim.keymap.set("n", "]<space>", "m`o<esc>``", { noremap = true, silent = true })
vim.keymap.set("n", "[<space>", "m`O<esc>``", { noremap = true, silent = true })

-- map `]e` and `[e` to move line down and up
vim.keymap.set("n", "]e", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "[e", ":m .-2<CR>==", { noremap = true, silent = true })

-- vim.keymap.set("n", "<leader>d", function()
--   vim.diagnostic.open_float(nil, { focus = false })
-- end, { desc = "Show diagnostic float" })
