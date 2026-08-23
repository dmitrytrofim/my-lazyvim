-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Гарантированное открытие проводника ТОЛЬКО при старте проекта
vim.api.nvim_create_autocmd("BufReadPost", {
  once = true, -- Срабатывает ровно один раз при загрузке самого первого файла
  callback = function()
    -- Если открыт стартовый дашборд, коммит или дифф — ничего не делаем
    if vim.bo.filetype == "snacks_dashboard" or vim.bo.filetype == "gitcommit" or vim.bo.filetype == "diff" then
      return
    end

    -- Даем LazyVim отрисовать файл, а затем мягко открываем боковую панель справа
    vim.schedule(function()
      if Snacks and Snacks.picker and Snacks.picker.explorer then
        Snacks.picker.explorer({ enter = false })
      end
    end)
  end,
})

