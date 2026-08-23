return {
  -- Заменяем старое имя 'echasnovski/mini.animate' на новое актуальное
  "nvim-mini/mini.animate",
  opts = function(_, opts)
    -- Оставляем настройки отключения конфликтующих анимаций для Neovide
    opts.resize = { enable = false }
    opts.open = { enable = false }
    opts.close = { enable = false }
  end,
}
