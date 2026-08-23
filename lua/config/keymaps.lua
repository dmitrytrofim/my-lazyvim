-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Быстрый возврат на стартовую страницу на Пробел + h (Home)
vim.keymap.set("n", "<leader>h", function()
  require("snacks").dashboard.open()
end, { desc = "Open home" })
