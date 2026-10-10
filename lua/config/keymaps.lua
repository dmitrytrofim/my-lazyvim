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
-- Перемещение вкладок-буферов влево и вправо по Alt + Shift + h/l
vim.keymap.set("n", "<A-S-h>", "<cmd>BufferLineMovePrev<cr>", { desc = "Сдвинуть вкладку влево" })
vim.keymap.set("n", "<A-S-l>", "<cmd>BufferLineMoveNext<cr>", { desc = "Сдвинуть вкладку вправо" })

pcall(vim.keymap.del, "n", "gf")

vim.keymap.set("n", "gf", function()
  local line = vim.api.nvim_get_current_line()
  
  -- Если строка содержит импорт/require, используем "умный" текстовый поиск,
  -- который просит Snacks найти точное совпадение имени файла в проекте.
  -- Это на 100% защищает от любых изменений алиасов в tsconfig.json!
  if line:match("import") or line:match("from") or line:match("require") then
    -- Извлекаем то, что в кавычках (например, "@aliased/components/DailyBonusRow")
    local path = line:match("['\"`]([^'\"`]+)['\"`]")
    
    if path then
      -- Берем только имя самого файла/компонента (DailyBonusRow)
      local filename = vim.fs.basename(path)
      
      -- Запускаем Snacks.picker, который мгновенно найдет РЕАЛЬНЫЙ файл по его имени,
      -- где бы он ни лежал в проекте и какой бы безумный алиас ни стоял вначале.
      require("snacks").picker.files({
        search = filename,
        title = "Jump to: " .. filename,
        auto_confirm = true, -- Если файл один, он откроется мгновенно без окон
      })
      return
    end
  end

  -- Фолбек: для всех остальных случаев (обычные файлы, логи) оставляем родной gf
  local ok = pcall(vim.cmd, "normal! f")
  if not ok then
    vim.notify("Путь не найден", vim.log.levels.WARN)
  end
end, { desc = "True Alias Go to File (gf)", silent = true })
