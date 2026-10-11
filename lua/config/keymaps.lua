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

-- Быстрый прыжок по словам через Ctrl + Стрелки в режиме вставки
vim.keymap.set("i", "<C-Left>", "<C-o>b", { desc = "Прыжок на слово назад" })
vim.keymap.set("i", "<C-Right>", "<C-o>e<Right>", { desc = "Прыжок на слово вперед" })

-- Удаление слова целиком через Ctrl + Backspace в режиме вставки
-- Прописываем оба возможных кода клавиши, чтобы работало в любых терминалах и Neovide
vim.keymap.set("i", "<C-Backspace>", "<C-w>", { desc = "Удалить слово слева" })
vim.keymap.set("i", "<C-H>", "<C-w>", { desc = "Удалить слово слева (fallback)" })

-- Ctrl + Enter в Insert mode создает чистую строку снизу и переходит на неё
vim.keymap.set("i", "<C-CR>", "<C-o>o", { desc = "Создать чистую строку снизу" })
-- Для некоторых дистрибутивов Linux и Neovide дублируем через код NL (New Line)
vim.keymap.set("i", "<C-NL>", "<C-o>o", { desc = "Создать чистую строку снизу (fallback)" })

-- Ctrl + Shift + Enter в Insert mode создает чистую строку сверху и переходит на неё
vim.keymap.set("i", "<C-S-CR>", "<C-o>O", { desc = "Создать чистую строку сверху" })
-- Для Linux/Neovide дублируем через код NL на случай альтернативного маппинга клавиш
vim.keymap.set("i", "<C-S-NL>", "<C-o>O", { desc = "Создать чистую строку сверху (fallback)" })
