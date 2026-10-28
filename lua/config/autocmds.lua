-- Защита от случайных нажатий в read-only и служебных буферах
local readonly_protection_group = vim.api.nvim_create_augroup("ReadonlyProtection", {
    clear = true
})

vim.api.nvim_create_autocmd({"BufWinEnter", "BufEnter"}, {
    group = readonly_protection_group,
    pattern = "*",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()

        -- ИСКЛЮЧЕНИЕ ДЛЯ AVANTE: Не блокируем клавиши в окнах diff, ask и т.д.
        -- Avante использует filetype = "Avante" и/или buftype = "acwrite"
        if vim.bo[bufnr].filetype == "Avante" or vim.bo[bufnr].buftype == "acwrite" then
            return
        end

        -- Если буфер нельзя изменять или он только для чтения
        if not vim.bo[bufnr].modifiable or vim.bo[bufnr].readonly then
            -- Блокируем клавиши перехода в режим вставки (Insert Mode)
            local insert_keys = {"i", "I", "a", "A", "o", "O", "s", "S", "c", "C"}
            for _, key in ipairs(insert_keys) do
                vim.keymap.set("n", key, "<Nop>", {
                    buffer = bufnr,
                    silent = true,
                    nowait = true
                })
            end

            -- Если это служебное окно без файла, разрешаем закрыть его на "q"
            if vim.bo[bufnr].buftype == "nofile" or vim.bo[bufnr].filetype == "help" then
                vim.keymap.set("n", "q", ":close<CR>", {
                    buffer = bufnr,
                    silent = true,
                    nowait = true
                })
            end
        end
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = {"html", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "xml"},
    group = vim.api.nvim_create_augroup("WebIndentSettings", {
        clear = true
    }),
    callback = function()
        -- Отключаем старый smartindent, чтобы он не мешал ESLint/Prettier форматировать код
        vim.opt_local.indentexpr = ""
        vim.opt_local.smartindent = false
        vim.opt_local.autoindent = true

        -- Умная проверка: если LazyVim УЖЕ нашел настройки проекта (ESLint/.editorconfig),
        -- то мы НЕ перезаписываем их своими двойками. 
        -- Если проект чистый — включаем ваши стандартные 2 пробела.
        if vim.snippet then -- Простая проверка, что буфер полностью инициализирован
            -- Проверяем, менял ли кто-то отступы до нас (например, встроенный детектор проекта)
            local current_sw = vim.bo.shiftwidth
            if current_sw == 8 or current_sw == 0 then -- 8 — это дефолт голого Vim'а
                vim.opt_local.expandtab = true
                vim.opt_local.shiftwidth = 2
                vim.opt_local.tabstop = 2
                vim.opt_local.softtabstop = 2
            end
        end

        -- 2. Магия для Enter внутри тегов (оставляем без изменений)
        vim.keymap.set("i", "<CR>", function()
            local line = vim.api.nvim_get_current_line()
            local col = vim.api.nvim_win_get_cursor(0)[2]
            if col > 0 and line:sub(col, col) == ">" and line:sub(col + 1, col + 1) == "<" then
                return "<CR><Esc>O<Tab>"
            else
                return "<CR>"
            end
        end, {
            expr = true,
            buffer = true,
            remap = false
        })
    end
})

local term_group = vim.api.nvim_create_augroup("TerminalEscFix", {
    clear = true
})

vim.api.nvim_create_autocmd("TermOpen", {
    group = term_group,
    callback = function(event)
        -- 1. Корректно отключаем задержку локально для буфера терминала
        vim.opt_local.timeoutlen = 0

        -- 2. Назначаем мгновенный выход без вывода мусорных кодов
        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], {
            buffer = event.buf,
            silent = true,
            desc = "Instant escape terminal mode"
        })
    end
})

-- ==========================================
-- АВТО-ОБНОВЛЕНИЕ ФАЙЛОВ (Для Avante и других инструментов)
-- ==========================================
local autoread_group = vim.api.nvim_create_augroup("AutoReadReload", {
    clear = true
})

-- Проверяем изменения при фокусе окна, переключении буферов и бездействии
vim.api.nvim_create_autocmd({"FocusGained", "BufEnter", "CursorHold"}, {
    group = autoread_group,
    pattern = "*",
    command = "checktime",
    desc = "Перечитывать файл с диска, если он изменился извне (например, Avante)"
})
