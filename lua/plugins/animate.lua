return {
  "nvim-mini/mini.animate",
  opts = {
    -- ПОЛНОСТЬЮ ОТКЛЮЧАЕМ СКРОЛЛ ПЛАГИНА (чтобы он не боролся с Neovide)
    scroll = { enable = false },
    
    -- Оставляем окна выключенными (чтобы боковая панель не двоилась при закрытии)
    resize = { enable = false },
    open = { enable = false },
    close = { enable = false },
  },
}
