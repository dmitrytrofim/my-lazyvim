-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Быстрый возврат на стартовую страницу на Пробел + h (Home)
vim.keymap.set("n", "<leader>h", function()
  require("snacks").dashboard.open()
end, { desc = "Open home" })

-- Одна кнопка для сохранения ВСЕГО (и в Normal, и в Insert режимах)
-- Для Normal режима
vim.keymap.set('n', '<F5>', '<cmd>wall<cr>', { desc = 'Сохранить все файлы' })
-- Для Insert режима (теперь ничего лишнего вставляться не будет)
vim.keymap.set('i', '<F5>', '<C-O><cmd>wall<cr>', { desc = 'Сохранить все файлы' })


