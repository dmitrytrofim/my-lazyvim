vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "xml" },
  group = vim.api.nvim_create_augroup("WebIndentSettings", { clear = true }),
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
    end, { expr = true, buffer = true, remap = false })
  end,
})


-- Автоматическая очистка кэша bufferline для закрытых файлов
vim.api.nvim_create_autocmd("BufDelete", {
  callback = function(args)
    if git_root_cache then
      git_root_cache[args.buf] = nil
    end
  end,
})

local term_group = vim.api.nvim_create_augroup("TerminalEscFix", { clear = true })

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
  end,
})

local snacks_mouse_isolate = vim.api.nvim_create_augroup("SnacksMouseIsolate", { clear = true })

-- 1. При входе в проводник отключаем режимы выделения мыши (оставляем только клики 'n' и 'c')
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "BufWinEnter" }, {
  group = snacks_mouse_isolate,
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "snacks_picker_list" or vim.bo.filetype == "snacks_picker_input" then
      vim.opt.mouse = "nc"
    end
  end,
})

-- 2. При выходе из проводника обратно в код возвращаем полноценную мышь со стандартным выделением
vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave" }, {
  group = snacks_mouse_isolate,
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "snacks_picker_list" or vim.bo.filetype == "snacks_picker_input" then
      -- Используем vim.schedule, чтобы Neovim вернул мышь ровно в тот кадр, когда фокус перешел на файл кода
      vim.schedule(function()
        if vim.bo.filetype ~= "snacks_picker_list" and vim.bo.filetype ~= "snacks_picker_input" then
          vim.opt.mouse = "a"
        end
      end)
    end
  end,
})
