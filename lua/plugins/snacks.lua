return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
      replace_netrw = true,
    },
    picker = {
      sources = {
        explorer = {
          hidden = true,            -- Показывать скрытые файлы (.env, .gitignore)
          focus = "list",           -- ФОКУС СРАЗУ НА СПИСОК ФАЙЛОВ, а не на строку поиска
          auto_close = true,        -- ЗАКРЫВАТЬ панель при выборе файла в дереве
          jump = { close = true },  -- ЗАКРЫВАТЬ панель в момент открытия файла в редакторе
          cwd = true,               -- Автоматически подхватывать корень нового проекта
          layout = {
            layout = {
              position = "left",    -- Панель открывается слева
              width = 30,
              min_width = 30,
            },
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader>fe",
      function()
        if Snacks and Snacks.picker and Snacks.picker.explorer then
          -- enter = true переносит курсор внутрь панели при её вызове
          Snacks.picker.explorer({ enter = true })
        end
      end,
      desc = "Explorer",
    },
  },
}
