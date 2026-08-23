if vim.g.neovide then
  -- Отключает анимацию изменения размера и перемещения окон (убирает шлейф Neo-tree)
  vim.g.neovide_window_animation_length = 0
  
  -- Дополнительно: делает анимацию появления новых окон мгновенной
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
end
ppfp