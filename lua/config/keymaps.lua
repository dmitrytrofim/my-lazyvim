-- ~/.config/nvim/lua/config/keymaps.lua
local macros = require("config.macros")

-- Копировать класс как CSS-правило
vim.keymap.set("n", "<F12>", require("config.macros").copy_class_to_right_window, {
    desc = "Send class to right window"
})

-- Быстрый возврат на стартовую страницу на Пробел + h (Home)
vim.keymap.set("n", "<leader>h", function()
    require("snacks").dashboard.open()
end, {
    desc = "Open home"
})

-- 1. F5 для сохранения и форматирования (в обычном режиме)
vim.keymap.set('n', '<F5>', function()
    -- Сначала форматируем (ручной вызов, который у тебя работает)
    require("conform").format({
        async = true,
        lsp_format = "fallback"
    })
    -- Затем сохраняем все файлы
    vim.cmd("wall")
end, {
    desc = 'Форматировать и сохранить все файлы'
})

-- 2. F5 для сохранения и форматирования (в режиме вставки)
vim.keymap.set('i', '<F5>', function()
    -- Выходим из режима вставки, чтобы conform мог работать корректно
    vim.cmd("stopinsert")
    -- Форматируем
    require("conform").format({
        async = true,
        lsp_format = "fallback"
    })
    -- Сохраняем
    vim.cmd("wall")
end, {
    desc = 'Форматировать и сохранить все файлы'
})

-- Перемещение вкладок-буферов влево и вправо по Alt + Shift + h/l
vim.keymap.set("n", "<A-S-h>", "<cmd>BufferLineMovePrev<cr>", {
    desc = "Сдвинуть вкладку влево"
})
vim.keymap.set("n", "<A-S-l>", "<cmd>BufferLineMoveNext<cr>", {
    desc = "Сдвинуть вкладку вправо"
})

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
                auto_confirm = true -- Если файл один, он откроется мгновенно без окон
            })
            return
        end
    end

    -- Фолбек: для всех остальных случаев (обычные файлы, логи) оставляем родной gf
    local ok = pcall(vim.cmd, "normal! f")
    if not ok then
        vim.notify("Путь не найден", vim.log.levels.WARN)
    end
end, {
    desc = "True Alias Go to File (gf)",
    silent = true
})

-- Быстрый прыжок по словам через Ctrl + Стрелки в режиме вставки
vim.keymap.set("i", "<C-Left>", "<C-o>b", {
    desc = "Прыжок на слово назад"
})
vim.keymap.set("i", "<C-Right>", "<C-o>e<Right>", {
    desc = "Прыжок на слово вперед"
})

-- Удаление слова целиком через Ctrl + Backspace в режиме вставки
-- Прописываем оба возможных кода клавиши, чтобы работало в любых терминалах и Neovide
vim.keymap.set("i", "<C-Backspace>", "<C-w>", {
    desc = "Удалить слово слева"
})
vim.keymap.set("i", "<C-H>", "<C-w>", {
    desc = "Удалить слово слева (fallback)"
})

-- Ctrl + Enter в Insert mode создает чистую строку снизу и переходит на неё
vim.keymap.set("i", "<C-CR>", "<C-o>o", {
    desc = "Создать чистую строку снизу"
})
-- Для некоторых дистрибутивов Linux и Neovide дублируем через код NL (New Line)
vim.keymap.set("i", "<C-NL>", "<C-o>o", {
    desc = "Создать чистую строку снизу (fallback)"
})

-- Ctrl + Shift + Enter в Insert mode создает чистую строку сверху и переходит на неё
vim.keymap.set("i", "<C-S-CR>", "<C-o>O", {
    desc = "Создать чистую строку сверху"
})
-- Для Linux/Neovide дублируем через код NL на случай альтернативного маппинга клавиш
vim.keymap.set("i", "<C-S-NL>", "<C-o>O", {
    desc = "Создать чистую строку сверху (fallback)"
})

-- Переключение окон в нормальном режиме (Normal mode)
vim.keymap.set("n", "<F4>", "<C-w>w", {
    desc = "Перейти в следующее окно"
})
vim.keymap.set("n", "<F3>", "<C-w>W", {
    desc = "Вернуться в предыдущее окно"
})

-- Переключение на следующее окно и прыжок в конец файла
vim.keymap.set("n", "<leader><F4>", "<C-w>wG", {
    desc = "Перейти в следующее окно и в конец"
})

-- Переключение на предыдущее окно и прыжок в конец файла
vim.keymap.set("n", "<leader><F3>", "<C-w>WG", {
    desc = "Перейти в предыдущее окно и в конец"
})

-- Переключение окон прямо во время набора текста (Insert mode)
-- Используем знакомую магию <C-o>, чтобы не выходить из режима вставки
vim.keymap.set("i", "<F4>", "<C-o><C-w>w", {
    desc = "Перейти в следующее окно"
})
vim.keymap.set("i", "<F3>", "<C-o><C-w>W", {
    desc = "Вернуться в предыдущее окно"
})

-- Мгновенный сброс зависших ошибок в текущем файле
vim.keymap.set("n", "<leader>dr", function()
    vim.diagnostic.reset()
    vim.cmd("edit!") -- Принудительно обновляет буфер файла на экране
end, {
    desc = "Сбросить зависшие ошибки (LSP Refresh)"
})

-- Shift + Пробел в режиме вставки мгновенно перемещает курсор в конец строки
vim.keymap.set("i", "<S-Space>", "<End>", {
    desc = "В конец строки"
})
-- Перемещение в начало строки на Ctrl + A (тоже полезно)
vim.keymap.set("i", "<C-a>", "<Home>", {
    desc = "В начало строки"
})

-- F1 показывает типы, пропсы и документацию (Hover LSP)
vim.keymap.set("n", "<F1>", vim.lsp.buf.hover, {
    desc = "Показать документацию/типы"
})
vim.keymap.set("i", "<F1>", "<C-o><cmd>lua vim.lsp.buf.hover()<cr>", {
    desc = "Показать документацию/типы"
})

-- F2 запускает умное переименование (Rename)
vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, {
    desc = "Переименовать сущность"
})
vim.keymap.set("i", "<F2>", "<C-o><cmd>lua vim.lsp.buf.rename()<cr>", {
    desc = "Переименовать сущность"
})

vim.keymap.set("n", "<leader>o", "o<Esc>", {
    desc = "Insert line below (stay in normal mode)"
})
vim.keymap.set("n", "<leader>O", "O<Esc>", {
    desc = "Insert line above (stay in normal mode)"
})
