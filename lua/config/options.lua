vim.opt.number = true
vim.opt.relativenumber = false

-- Глобальный выключатель плавности самого Neovim (убирает микро-лаги)
vim.opt.smoothscroll = false 

-- 2. Специфичные настройки для графического интерфейса Neovide
if vim.g.neovide then
  -- Абсолютный и жесткий ноль для скролла на уровне GUI
  vim.g.neovide_scroll_animation_length = 0.0
  vim.g.neovide_position_animation_length = 0.0
  
  -- Полное отключение анимации курсора (как в VS Code)
  vim.g.neovide_cursor_animation_length = 0.0
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_vfx_mode = "none"
  vim.g.neovide_cursor_animate_command_line = false

  -- Скорость прокрутки колесиком мыши
  vim.opt.mousescroll = "ver:7,hor:6"

  -- Полезные фичи для комфорта
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_progress_bar_enabled = false
end
