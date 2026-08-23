return {
  -- 1. Возвращаем отключение анимации курсора
  {
    "nvim-mini/mini.animate",
    opts = {
      cursor = { enable = false },
    },
  },
  -- 2. Фиксируем стартовый экран, чтобы lazy.nvim перестал просить его удалить
  { "nvimdev/dashboard-nvim", event = "VimEnter" },
}
