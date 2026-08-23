-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

if vim.g.neovide then
  vim.g.neovide_scroll_animation_length = 0.05 
  vim.g.neovide_cursor_animation_length = 0.04
  vim.g.neovide_cursor_trail_size = 0.4
  vim.opt.mousescroll = "ver:7,hor:6"
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_hide_mouse_when_typing = true
end
