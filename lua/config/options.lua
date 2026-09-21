-- Базовые настройки интерфейса
vim.opt.number = true
vim.opt.relativenumber = false

-- Специфичные настройки для графического интерфейса Neovide
if vim.g.neovide then
  -- Максимально быстрая прокрутка экрана (0.1 секунды вместо 0.3)
  -- Экран перемещается мгновенно, но сохраняет микро-сглаживание без рывков
  vim.g.neovide_scroll_animation_length = 0.1

  -- ПОЛНОЕ отключение анимации курсора
  -- Курсор будет перемещаться абсолютно жестко и мгновенно, как в стандартном терминале или VS Code
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_vfx_mode = "none"

  -- Скорость прокрутки колесиком мыши (оставляем для удобной навигации)
  vim.opt.mousescroll = "ver:7,hor:6"

  -- Полезные фичи для комфорта
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_progress_bar_enabled = false
end
