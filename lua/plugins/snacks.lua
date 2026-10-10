return {
  "folke/snacks.nvim",
  opts = {
    scroll = { enabled = false }, -- Наш жесткий скролл без лагов
    indent = {
      enabled = true,
      animate = { enabled = false }, -- Базовый выкл анимаций сетки

      -- Фоновая сетка выключена полностью
      indent = { enabled = false },   

      -- Настройка единственной активной линии
      scope = {
        enabled = true,
        char = "│",
        -- ВКЛЮЧАЕМ блок, но выставляем время доезда в 0!
        -- Это заставит Snacks не сглаживать движение, а жестко перерисовывать
        -- линию на новом месте в тот же кадр, когда прыгнул курсор.
        animate = {
          enabled = true,
          duration = 0, -- Мгновенное переключение (0 миллисекунд)
        },
      },
    },
    scope = { enabled = true },
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
