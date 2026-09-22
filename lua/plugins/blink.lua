return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        -- Отключаем автоматическое появление меню при наборе текста
        trigger = {
          prefetch_on_insert = false,
          show_on_keyword = false,
          show_on_trigger_character = false,
        },
        -- Отключаем автоматический предпросмотр (ghost text) в самой строке
        ghost_text = { enabled = false },
      },
    },
  },
}
