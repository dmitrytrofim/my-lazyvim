return {
  {
    "saghen/blink.cmp",
    opts = {
      -- Настройки клавиш
      keymap = {
        preset = "default",
        ["<Esc>"] = { "hide", "fallback" },

        -- Настройка стрелок для всех режимов (включая командную строку)
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
      },
      -- Явно включаем автодополнение для командной строки
      cmdline = {
        enabled = true,
        keymap = {
          preset = "default",
          -- Дублируем стрелки отдельно для cmdline, чтобы гарантировать работу
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
