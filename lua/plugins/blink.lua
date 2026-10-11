return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "default",
        ["<Esc>"] = { "hide", "fallback" },

        -- НАСТРОЙКА ENTER: если меню открыто — только вставляем подсказку (без новой строки!)
        ["<CR>"] = { "accept", "fallback" },

        -- Настройка стрелок для всех режимов
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
      },
      cmdline = {
        enabled = true,
        keymap = {
          preset = "default",
          -- Дублируем настройки для командной строки
          ["<CR>"] = { "accept", "fallback" },
          ["<Up>"] = { "select_prev", "fallback" },
          ["<Down>"] = { "select_next", "fallback" },
        },
      },
      completion = {
        trigger = {
          prefetch_on_insert = true,
          show_on_keyword = true,
          show_on_trigger_character = true,
        },
        ghost_text = { enabled = true },
      },
    },
  },
}
