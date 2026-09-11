vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue", "xml" },
  callback = function()
    -- 1. Ваши текущие настройки отступов (оставляем без изменений)
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2

    vim.opt_local.indentexpr = ""
    vim.opt_local.smartindent = false
    vim.opt_local.autoindent = true

    -- 2. Магия для Enter внутри тегов (как в VS Code)
    -- Функция проверяет, находятся ли слева и справа символы '>' и '<'
    vim.keymap.set("i", "<CR>", function()
      local line = vim.api.nvim_get_current_line()
      local col = vim.api.nvim_win_get_cursor(0)[2]

      -- Если курсор стоит ровно между '>' и '<' (например, <div>|</div>)
      if col > 0 and line:sub(col, col) == ">" and line:sub(col + 1, col + 1) == "<" then
        -- Разносим теги на три строки, делаем отступ и ставим курсор посередине
        return "<CR><Esc>O<Tab>"
      else
        -- В остальных случаях работает обычный «тупой» перенос строки
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
