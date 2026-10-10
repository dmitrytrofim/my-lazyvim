return {
  "folke/snacks.nvim",
  opts = {
    scroll = { enabled = false }, -- Наш жесткий скролл без лагов
    explorer = { replace_netrw = true },
    picker = {
      sources = {
        explorer = {
          hidden = true,
          focus = "list",
          auto_close = true,
          jump = { close = true },
          cwd = true,
          layout = { layout = { position = "left", width = 30, min_width = 30 } },
          win = {
            input = {
              keys = {
                -- Возвращаем Esc для прыжка из строки поиска в список файлов
                ["<Esc>"] = { "focus_list", mode = { "i", "n" } },
              },
            },
            -- НАСТРОЙКА ДЛЯ СПИСКА ФАЙЛОВ
            list = {
              keys = {
                -- Переназначаем 'o' на открытие файла ВНУТРИ Neovim вместо браузера
                ["o"] = "confirm",
              },
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
          Snacks.picker.explorer({ enter = true })
        end
      end,
      desc = "Explorer",
    },
  },
}
