-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- ========================================================================== --
-- НАСТРОЙКИ СКОРОСТИ И АНИМАЦИИ ДЛЯ NEOVIDE
-- ========================================================================== --
if vim.g.neovide then
  -- 1. Скролл: делаем его экстремально быстрым (по умолчанию 0.3 секунды)
  vim.g.neovide_scroll_animation_length = 0.05 

  -- 2. Курсор: ускоряем его прыжки, чтобы он не "плыл" лениво по экрану
  vim.g.neovide_cursor_animation_length = 0.04

  -- 3. Шлейф курсора: делаем его короче, чтобы код не размывался при движении
  vim.g.neovide_cursor_trail_size = 0.4
  
  -- Задаем количество строк для прокрутки колесиком мыши (например, 7 строк за раз)
  vim.opt.mousescroll = "ver:7,hor:6"
end

if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0 -- Убирает время анимации (курсор перемещается мгновенно)
  vim.g.neovide_cursor_trail_size = 0        -- Убирает шлейф за курсором
end